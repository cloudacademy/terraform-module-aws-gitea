# Gitea Terraform Module

A Terraform module for standing up a Gitea instance for a short-lived laboratory session in an AWS account.

The Gitea instance is configured with a repository and Gitea actions are enabled.

See the [variables.tf](variables.tf) file for configurable options, and the [outputs.tf](outputs.tf) file for the available outputs.

## Testing locally

Create a `vars.tfvars` file with the following content, replacing the values with valid ones from your AWS account:

```hcl
key_pair_name = "your-key-pair-name"
security_group_id = "your-security-group-id"
```

Then run the following commands:

```bash
terraform init
terraform plan
terraform apply -var-file=vars.tfvars -auto-approve
```

After the instance is up and running, you can access the Gitea instance by navigating to the `login_url` output.

To destroy the instance, run:

```bash
terraform destroy -var-file=vars.tfvars -auto-approve
```

Notes:

- The EC2 instance runs the latest Amazon Linux 2023 AMI. The user data script is not portable to other Linux distributions.
- The runner runs on the same instance as the Gitea server. If performance is an issue we could consider running the runner on a separate instance.

## Usage

To use in a lab Terraform configuration, add the following code to your template:

```hcl
module aws_gitea {
    source = "github.com/cloudacademy/terraform-module-aws-gitea"

    key_pair_name       = "your-key-pair-name"
    security_group_id   = "your-security-group-id"
    subnet_id           = "your-subnet-id"
}
```

### Example with the AWS data module

The following will deploy gitea into a subnet in the default vpc.

```hcl
module "aws_data" {
  source = "github.com/cloudacademy/terraform-module-aws-data?ref=v1.0.1"
}

module "aws_gitea" {
    source = "github.com/cloudacademy/terraform-module-aws-gitea"

    key_pair_name       = module.aws_data.aws.key_pair_name
    security_group_id   = module.aws_data.default_vpc.security_group.id
    subnet_id           = module.aws_data.default_vpc.subnets.a.id
}
```

### Creating an empty repository

By default, there will be no repositories in Gitea.

To create an empty repository:

```hcl
module "aws_data" {
  source = "github.com/cloudacademy/terraform-module-aws-data?ref=v1.0.1"
}

module "aws_gitea" {
    source = "github.com/cloudacademy/terraform-module-aws-gitea"

    key_pair_name       = module.aws_data.aws.key_pair_name
    security_group_id   = module.aws_data.default_vpc.security_group.id
    create_empty_repo   = true
    empty_repo_name     = "name-of-your-repo"
}
```

### Cloning an existing repository

To create a repo that is a clone of an existing publicly repo (say on github):

```hcl
module "aws_data" {
  source = "github.com/cloudacademy/terraform-module-aws-data?ref=v1.0.1"
}

module "aws_gitea" {
    source = "github.com/cloudacademy/terraform-module-aws-gitea"

    key_pair_name       = module.aws_data.aws.key_pair_name
    security_group_id   = module.aws_data.default_vpc.security_group.id
    create_cloned_repo  = true
    cloned_repo_source  = "https://github.com/cloudacademy/python-flask-microservices.git"
}
```

### Notes

- The AWS instance's role ARN is exposed as an output and a managed policies list can be supplied as a variable. Both can be used to grant the Gitea runner access to AWS resources and services.
- The runner is disabled by default and can be enabled by setting the `create_runner` variable to `true`.
- A secret at the user level can be created by setting `create_secret` to `true`, and the name and value can be set with the `secret_name` and `secret_value` variables.
