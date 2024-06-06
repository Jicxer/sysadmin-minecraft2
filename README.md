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

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Diagram
The major steps in the pipeline include defining and creating AWS resources such as EC2.
We would also want to ensure that the Minecraft server automatically restarts on reboot.

1. Install dependencies using the install.sh script

Installing dependencies ensure that this pipeline will work accordingly.

2. Set up AWS configuration and credentials.
3. Run the Terraform script
4. Log into Minecraft

<p align="right">(<a href="#readme-top">back to top</a>)</p>


### Commands

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Connecting

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Next Steps

<p align="right">(<a href="#readme-top">back to top</a>)</p>

# Resources
[Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code)

[AWS Credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html)

[Minecraft docker image github](https://github.com/itzg/docker-minecraft-server)

[Minecraft docker image documentation](https://docker-minecraft-server.readthedocs.io/en/latest/)



<p align="right">(<a href="#readme-top">back to top</a>)</p>
