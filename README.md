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

With everything set, now we start by creating our modules folder(EC2,RDS,VPC) etc...
 <img width="1273" height="679" alt="Screenshot 2025-08-25 at 14 20 33" src="https://github.com/user-attachments/assets/74ceae6f-2fcc-4cfd-92ef-26d5bcfbfdc5" />basically this how its gonna be like.

# Lets talk about why i am using Backend.tf in the tree above;
Imagine you are running a fastfood joint which is patronized by almost everybody due to the taste of your food and infact getting a chunk of your competitors customer and the taste of your food is your recipe, now imagine not protecting or storing your recipe book in a secured location which can only be accessed by only your confidants or chefs, it means your competitors can steal your recipe which is the heart of your business and replicate it, thats when backend.tf comes in, this contains an s3 bucket(storing) and dynamodb(state-locking) which is used to store(s3 bucket) your recipe(tfstate-file) in an isolated environment, now this secure storage location has a padlock and the keys are given to the chefs,this padlock allows 1 chef access at a time so if chef A accesses the storage chef B cant until chef A is done and out of the storage and this enables stable and reliable infra-as-code workflow 

# Hashicorp Vault
Reason why i am using this in my project is because i dont want hardcoding my secret credentials and pushing it to the github, so with the vault i can store all my credentials and ask terraform to call on then when the need arises. To do that i first install the vault which i will provide a link for that below.
1.Create create an EC2 instance for vaukt, vault-server on AWS.

2.SSH into that note we are creatws a public ip instance for this project..

3.Install vault
  ```bash
   https://developer.hashicorp.com/vault/install
   ```
Should be done in a different terminal and for this project we are using the dev environment for vault...

4. Start vault in dev mode
   ```bash
   vault server -dev -dev-listen-address="0.0.0.0:8200"
  ```
4a.Open a different terminal and copy and past the export log in the old running terminal, remember you ssh into the same instance before export this,
```bash
export VAULT_ADDR='http://0.0.0.0:8200'
```

5.Enable Authorization for AppRole
```bash
  vault auth enable approle
```
6. Create a policy
```bash
vault policy write terraform - <<EOF
path "*" {
  capabilities = ["list", "read"]
}
path "secrets/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "kv/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "auth/token/create" {
  capabilities = ["create", "read", "update", "list"]
}
EOF
Always remember you can fall on documentations you not entirely supposed to get all this in your head lol😂..

7.Lets bind the policy with the role
```bash
vault write auth/approle/role/terraform \
    secret_id_ttl=10m \
    token_num_uses=10 \
    token_ttl=20m \
    token_max_ttl=30m \
    secret_id_num_uses=40 \
    token_policies=terraform
```
After we check the roleID and secretID for the vault....
Covered enough on vault


 







