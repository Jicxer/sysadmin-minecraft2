# sysadmin-minecraft2
Course Project Part 2 for System Administrator Spring 2024. We will be automating a minecraft server

<a name="readme-top"></a>

# Table of Contents
1. [Background](#background)
2. [Guidelines](#guidelines)
3. [Requirements](#requirements)
4. [Diagram](#diagram)
5. [Commands](#commands)
6. [Connecting to server](#connect)
7. [Next Steps](#next-steps)
8. [Resources](#resources)


# Minecraft Server Setup on AWS

## Background 
As a system administrator, it is our job to automate processes. We will automate the provisioning, configuration, and the set up of a Minecraft server using 
Infastructure as Code (IAC) tools like Terraform. 

Our objective is to ensure that a server can be set up efficiently and quickly across different environments.
We will be using Terraform to automate the process of setting up a Minecraft server using Amazon Web Services (AWS).
We will provision resources such as EC2 and have a configured network Public IPv4 address to which players can connect to.
Additionally, we will have the Minecraft server able to restart when the provisioned resources restart along with a proper shutdown.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Guidelines
- Setup a git repo
- Write infrastructure provisioning scripts (e.g., Terraform, Pulumi, Ansible, ...) to set up your AWS resources
    Provision compute resources (EC2, ECS, EKS, or else)
    Setup networking
    (Optional) Specify and configure the Docker image to deploy
- (Optional) Write a configuration script to set up your Minecraft server (e.g., Ansible, bash, ...)
- Make sure that, through your scripts, the Minecraft server is configured to restart when the resources reboot.
    From the previous documentation, the server auto-started but was not shutting down properly (look into how to stop the service properly).
- Connect to your instance's public IP address (i.e., your Minecraft server address) with nmap -sV -Pn -p T:25565 <instance_public_ip>
- Write the documentation as the git repo's README, and have all the scripts versioned.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Requirements

To utilize this pipeline, the user will need the following resources and dependencies:
- Git 
- AWS CLI
- AWS Account
- Terraform
- Minecraft Client
- Ansible
- Docker

The install script ```install.sh``` will install the dependencies AWS CLI, Terraform, and Git if the user does not already have it.

### Terraform
[Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code) is an open-source tool that allows the user to manage AWS along with other provides such as Docker. It provides readable configuration language that can help users write and deploy infastructure of code quickly.

### Docker
A [Minecraft docker image](https://github.com/itzg/docker-minecraft-server) will be used for this pipeline.
This docker image uses docker compose and is compatible with various server types.
The documentation is provided [here](https://docker-minecraft-server.readthedocs.io/en/latest/)

### Ansible

Ansible allows for infastructure as code. It is used for provisioning and configuraiton. The configuration will be mostly accomplished by YAML using the ansible playbook. 

#### Ansible Playbook and YAML
Ansible Playbook will contain a list of instrutions for configuration written in YAML. The purpose of the playbook for the project is to install:
- Docker
- Minecraft Server Docker Image
- Docker dependencies
- Enabling Minecraft server on System Start up

### Amazon Web Services
The user will need to set-up their AWS credentials for Terraform functionality.
Copy and paste the [AWS credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html) into ```~/.aws/credentials``` file.

The formating would look similar to this:
```
[default]
aws_access_key_id=ASIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
aws_session_token = IQoJb3JpZ2luX2IQoJb3JpZ2luX2IQoJb3JpZ2luX2IQoJb3JpZ2luX2IQoJb3JpZVERYLONGSTRINGEXAMPLE

[user1]
aws_access_key_id=ASIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
aws_session_token = fcZib3JpZ2luX2IQoJb3JpZ2luX2IQoJb3JpZ2luX2IQoJb3JpZ2luX2IQoJb3JpZVERYLONGSTRINGEXAMPLE
```

#### AWS Learning Lab
If the user is using an AWS Learner Lab version, they will need to make modifications to how the credentials assignment work for AWS CLI.
Follow the steps below to configure AWS credentials:
1. Start Learner Lab

Do this by clicking on "Start Lab" button.
2. Once the lab has started, navigate to AWS Details

This will show details about the current Lab session. The user should be able to access the AWS CLI credentials for this session by clicking on the Show button next to
"AWS CLI"

3. Copy credentials

Navigating to the AWS CLI credentials section will reveal the current session's variables needed for authentication:
- aws_secret_key
- aws_secret_access_key
- aws_session_token

Be sure to copy these contents to paste into the ```~/.aws/credentials``` file.

Depending on what profile you are using, edit the profile variable in variables.tf
```
variable "profile"{
    description = "AWS Learner Lab Profile"
    default = "learner_lab"
}
```
For the case of this tutorial, the profile was under "learner_lab". Feel free to change this depending on what profile you placed the credentials under.
This will specify what AWS account will be used.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Diagram
The major steps in the pipeline include defining and creating AWS resources such as EC2.
We would also want to ensure that the Minecraft server automatically restarts on reboot.

1. Install dependencies using the install.sh script

Installing dependencies ensure that this pipeline will work accordingly.

2. Set up AWS configuration and credentials.

This is to ensure that we are able to provision resources and build the infastructure with terraform and ultimately set up the Minecraft server

3. Run the Terraform script

``` 
terraform init
terraform apply
```

Terraform script will handle:
- Minecraft Server Docker Image
- AWS Resource Provision

    This will create an EC2 instance called "minecraft"
    
    The instance type will be "t2.small" and the operating system will be Debian AMI.
    
    This will also create an ansible inventory "inventory.ini" that will be used to SSH into the instance and install the Minecraft Server Docker Image dependencies.

    A new key-pair will be created for the sake of Ansible connection to the EC2.

- IPv4 Address assignment for Minecraft Server
- Minecraft Security Group

    The security group will allow the Minecraft port of 25565 and the ssh port of 22 from any CIDR block or IP. 
    This is for the purpose of ssh into the instance and install required dependencies.
- AWS Credentials

4. Run Ansible Playbook to configure EC2 Instance
```

4. Log into Minecraft

Use the Public IPv4 that was established earlier from Terraform infastructure setup.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Commands

1. Set up the Git Repository

Clone the repository and navigate to the project directory
```
git clone https://github.com/Jicxer/sysadmin-minecraft2.git
cd sysadmin-minecraft2.git
``` 
2. Install dependencies

```
./install.sh
```

3. Initialize and apply the Terraform resources and configuration

```
terraform init -upgrade
terraform apply
```

This will create the EC2 instance and generate the 'inventory.ini" with a public instance IP address from the EC2 instance.
4. Start the Ansible playbook using the YAML configurations
```
ansible-playbook -i inventory.ini playbook.yml
```


<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Connecting

Once Ansible Playbook has finished configuring the EC2 Instance, the player can now connect to the Minecraft Server.

The Public IP address is provided as an output after running Ansible.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Next Steps

Installing Mods on Minecraft

<p align="right">(<a href="#readme-top">back to top</a>)</p>

# Resources
[Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code)

[Terraform Hashicorp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

[AWS Credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html)

[Minecraft docker image github](https://github.com/itzg/docker-minecraft-server)

[Minecraft docker image documentation](https://docker-minecraft-server.readthedocs.io/en/latest/)

[Adding IP Address to Terraform](https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add)

[Install Docker using Ansible Playbook](https://www.digitalocean.com/community/tutorials/how-to-use-ansible-to-install-and-set-up-docker-on-ubuntu-20-04)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
