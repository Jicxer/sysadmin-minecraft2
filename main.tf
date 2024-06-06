terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

# https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add
provider "http" {}

data "http" "my_ip" {
  url = "https://api.ipify.org?format=text"
}

locals {
  my_ip_cidr = "${chomp(data.http.my_ip.body)}/32"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/private_key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "deployer" {
  key_name   = "minecraft-key"
  public_key = tls_private_key.example.public_key_openssh
}

provider "aws" {
  region                 = var.region
  shared_credentials_files = ["~/.aws/credentials"]
  shared_config_files    = ["~/.aws/config"]
  profile                = var.profile
}

resource "aws_security_group" "minecraft_securitygroup" {
  name_prefix = "minecraft_securitygroup"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami                         = "ami-0c2644caf041bb6de" # Debian AMI
  instance_type               = "t2.small"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.minecraft_securitygroup.id]
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name = "Minecraft Server"
  }

  provisioner "local-exec" {
    command = <<EOT
cat <<EOF > inventory.ini
[minecraft]
${self.public_ip} ansible_user=admin ansible_ssh_private_key_file="${path.module}/private_key.pem"
EOF
EOT
  }
}