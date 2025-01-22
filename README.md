# Hublink

## Short-lived SOCKS proxy in AWS

Prerequisites:
* [AWS Account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-creating.html) with a [user](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html) with the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed and configured.
* [jq](https://jqlang.github.io/jq/download/)
* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* Some flavor of Linux (For Windows [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) works)

### Initial Setup

1. [Clone the repository.](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
1. Create an SSH key with `ssh-keygen -t ed25519 -C Hublink` and note its name.
1. Run `cp env.example .env` and edit the _.env_ file to set the required variables.
  * `TF_VAR_ssh_key_name` should be the key name noted above.
  * `TF_VAR_ssh_public_key` is the contents of your key _.pub_ file.
1. Edit _main.tf_ and replace the `CHANGME`s with the [region](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions) you want the proxy in and a unique bucket name.
1. Run `source .env` to populate your environment.
1. Run `cd s3-backend` then `terraform init` and `terraform apply` to create the S3 bucket to store Terraform state.
1. Run `cd ..` then `terraform init` and `terraform apply` to set up the proxy instance and supporting infrastructure.
1. Run `sudo ln -s $(pwd)/hublink /usr/local/bin/hublink` to add the _hublink_ script to your PATH.
1. Run `hublink` to connect to the SOCKS proxy.
1. `ctrl+c` to disconnect and terminate the instance when done.

### Usage
1. Run `hublink` to connect to the SOCKS proxy.
1. Connect to the SOCKS proxy at _localhost_ port 666. [Windows instructions.](https://superuser.com/a/1767865)
1. When done browsing turn off proxy in Windows/Linux and `ctrl+c` to disconnect and terminate the proxy instance.
