# localk8_vpc
## Purpose
This project aims to provision a local kubernetes cluster, using terraform, ansible, hashicorp vault, proxmox, and aws. This project assumes that you have a hashicorp vault already configured in your environment. We are also assuming that you have terraform and ansible configured on your local deployment machine, and that you have a proxmox node configured. 

This kubernetes cluster is designed for a single host deployment, but can easily be modified to accomodate any number of physical host nodes. 

## Environmental Pre-reqs
First, make sure that you have HVAC installed. This is a requirement for ansible to collect vault secrets. To install HVAC, please run the following code from your terminal (Im running in a macOS environment):

```
pip3 install hvac
```

Once installed, you will need to configure the following environmental variables within your terminal:

```
export VAULT_TOKEN="The Token Value to log into Hashicorp Vault"
export VAULT_ADDR="The URL of your vault"
```

Performing these steps will allow Ansible to provision assets into your environment, calling secrets from Hashicorp Vault to authenticate against proxmox. 

## Hashicorp Vault Contents
For this project to work, we are assuming that you already have a Hashicorp Vault instance somewhere accessable. Additionally, we assume that you have a vault configured with the following Secret engine and contents:

### Engine Details

Type: KV, version 1. 

Path: Proxmox/Terraform

Keys: 

1. api_token_id = username@pam!terraform
2. api_token_id_simple = terraform
3. api_token_secret = YourSecretContents
4. api_token_user = username@pam
5. api_url = https://proxmox.address:8006
6. aws_id = Your AWS ID
7. aws_secret = YourIDSecret

## Proxmox Configuration
In addition to a provisioned Hashicorp Vault, we also assume that you have the following things configured in Proxmox:

1. A Administator user with a fully permissioned API token named terraform. 
2. A Centos 9 Stream template (Provisioned with the official qcow2 image from RedHat) with the name "centos9-template". 
3. A storage volume in proxmox named "storage". 

## AWS Configuration
Currently not yet implemented, but this will configured to provide a link between your local k8 cluster and AWS so that the applications on the proxmox host can be served to the internet.

## Deployment Steps
Assuming that all the prereqs are met, you can simply deploy the project by running the following commands from your terminal:

```
git clone git@github.com:LittleSeneca/localk8_vpc.git
cd localk8_vpc
terraform init
terraform apply
ansible-playbook configuration.yml

```

When you run the terraform apply command, you will be prompted for the address of your terraform instance. This should be in the format http://terraform.address:port. 

Similarly, you will be asked for your vault login token. 

Once everything has finished running, you will have a fully available k8 cluster. To grab your cluster configuration, log into the k8-controller0 virtual machine and collect the cluster configuration from ~/.kubeconf.
