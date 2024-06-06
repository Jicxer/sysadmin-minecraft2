# sysadmin-minecraft2
Course Project Part 2 for System Administrator Spring 2024. We will be automating a minecraft server

<a name="readme-top"></a>

# Table of Contents
1. [Background](#background)
2. [Guidelines](#guidelines)
3. [Requirements](#requirements)
4. [Diagram](#diagram)
5. [Usage](#usage)
6. [Commands](#commands)
7. [Connecting to server](#connect)
8. [Next Steps](#next-steps)


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

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Diagram

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage

### Commands

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Connecting

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Next Steps

<p align="right">(<a href="#readme-top">back to top</a>)</p>