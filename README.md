# Infra-as-Code-IaC-for-a-Web-Application
### **Terraform configuration for deploying infrastructure on AWS, using Workspaces, Modules, and Vault.This project aims to demonstrate best practices for infrastructure as code(IaC) and provide a starting point for similar projects.Feel free to contribute,modify, and use this code for your own purposes**
### **Getting Started**
#### **1. Installation**
There are no complex installations! Will be using VScode for this project so we demonstrate our git commands proficeincy as well.Simply clone the repository to get started:
```bash
git clone https://github.com/kofi-dickson/Infra-as-Code-IaC-for-a-Web-Application
cd Infra-as-Code-IaC-for-a-Web-Application
```
Now we need to install and configure AWS,Harshicorp Vault and install Terraform:
```bash
curl https://awscli.amazonaws.com/AWSCLIV2.pkg -o AWSCLIV2.pkg
sudo installer -pkg AWSCLIV2.pkg -target /
aws --version
```
After AWS has been installed properly now we configure it:
```bash
aws configure
```
Where the most important thing required is the AWS Access and Secret Key which i presume you know if how.
Now we move to installing Terraform:
```bash
# Add the HashiCorp tap (repository) to Homebrew
brew tap hashicorp/tap

# Install Terraform
brew install hashicorp/tap/terraform

# Verify the installation
terraform --version
```
This is for my mac,you can as well check terraform documentations on how to install it on your preferred OS.




