# AWS IOT Pipeline

## Resources

This terraform configuration creates the below resources

  * IOT (thing group, type, thing and other supporting files (keys, certs etc.))
  * DynamoDB Table
  * IAM Role (To write to DDB)

## Authentication

I typically run this across several AWS accounts. Thus, I rely on Terraform workspaces on a local backend. Below is the provider block used in `main.tf`.

```hcl
provider "aws" {
  # Configuration options
  region = var.default_region
  # pick the profile matching current workspace name
  # comment if you have a single environment and use the default profile
  profile = terraform.workspace
}
```

Please make sure you have a profile matching your terraform workspace name in your AWS creds (`~/.aws/credentials`).

```
[workspace-name]
region=us-east-1
aws_access_key_id = <your-access-key>
aws_secret_access_key = <your-secret-access-key>
```

or pass the input variable `use_default_creds` as `true` to pick the default profile when you don't deal with multiple profiles/accounts.

## Executing

Create a new workspace (in the `infra` directory)

```bash
terraform workspace new "<workspace-name>"
```

OR select an existing workspace.

```bash
terraform workspace select "<workspace-name>"
```

Apply

```bash
terraform apply
```

## Stream Data

Create and activate a new virtual environment (in the `streamer` directory). 

Tested with Python 3.9. Fails with 3.12

```bash
python -m venv .venv
source .venv/Scripts/activate
```

Install requirements

```bash
pip install -r requirements.txt
```

Run the simulation script

```bash
./simul.sh
```

The script runs until you interrup it with `Ctrl + C`` (KeyboardInterrupt).
