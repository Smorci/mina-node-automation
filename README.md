# Mina-Node-Automation

This repository hosts an application that deploys a [Mina Node](https://github.com/MinaProtocol/mina) to a Google Cloud Compute instance with [Nix](https://nixos.org/), [Terraform](https://www.terraform.io/) and [Arion](https://github.com/hercules-ci/arion).

Currently there are two applications: deploy and destroy.

## Prerequisite

1. Nix with flake support installed. Instructions can be found [here](https://github.com/mschwaig/howto-install-nix-with-flake-support).
2. Google Cloud Provider account and project. For creating the project follow these [instructions](https://developers.google.com/workspace/guides/create-project).
3. Google Cloud Provider Service Account for the previously mentioned project and enable Google APIs mentioned in this [tutorial](https://gmusumeci.medium.com/how-to-create-a-service-account-for-terraform-in-gcp-google-cloud-platform-f75a0cf918d1). In addition to the APIs in the tutorial, also enable in the same way the Compute Engine API.
4. The service account credentials a .json file. It can be exported from Google Cloud.

## Usage

Clone the repository and enter the directory to run the following commands in the terminal.

### Deploy

**nix run** - deploys the Google Compute Instance with a NixOS configuration to your Google Cloud project and starts a container running the Mina node. Make sure to provide the right infromation for the terraform prompt.

> NOTE:
> At the end of the execution there will be an ssh command on the output which can be used to access the virtual machine.

### Destroy

**nix run .#destroy** - destroys the infrastructure from your Google Cloud project.

## Caveats

1. Currently the node doesn't produce blocks as the wallet key is not configured.
2. If you destroy the infrastructure and rebuild it you have to clear the records of the machine from *~/.ssh/known_hosts* before trying to connect with **ssh**.