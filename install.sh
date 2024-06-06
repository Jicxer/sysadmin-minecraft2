#!/bin/bash

sudo apt-get update
# Check dependencies


# Check if Terraform is already installed
if [ ! -f "/usr/local/bin/terraform" ]; then

    # Set the desired Terraform version
    TERRAFORM_VERSION="1.2.9"

    # Download Terraform. Adjust the version number as necessary.
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

    # Unzip the downloaded file
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

    # Move the executable to a directory included in the system's PATH
    sudo mv terraform /usr/local/bin/

    # Remove the downloaded ZIP file
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

    # Check the installation
    terraform --version

    # Print success message
    echo "Terraform installed successfully."

else
    echo "Terraform is already installed."
    terraform --version
fi

# Check if AWS CLI is already installed
if command -v aws >/dev/null 2>&1; then
    echo "AWS CLI is already installed."
    aws --version
else
    echo "AWS CLI is not installed. Proceeding with installation..."

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip aws/

fi

# Check if Ansible is already installed
if command -v ansible >/dev/null 2>&1; then
    echo "Ansible is already installed."
    ansible --version
else
    echo "Ansible is not installed. Proceeding with installation..."
    sudo apt-get install software-properties-common -y 
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install ansible -y
    ansible --version
fi

# Check if Docker is already installed
if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed."
    docker --version
else
    echo "Docker is not installed. Proceeding with installation..."
    sudo apt-get install docker.io
    docker --version
fi

echo "Installation script complete"