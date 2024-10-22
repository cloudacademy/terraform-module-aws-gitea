variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "EC2 instance name"
  type        = string
  default     = "gitea"
}

variable "image" {
  description = "Gitea docker image"
  type        = string
  default     = "public.ecr.aws/cloudacademy-labs/cloudacademy/labs/gitea:1.22.3-de167e2"
}

variable "username" {
  description = "Gitea username"
  type        = string
  default     = "student"
}

variable "password" {
  description = "Gitea password"
  type        = string
  default     = "LabPassword123"
}

variable "email" {
  description = "Gitea email"
  type        = string
  default     = "student@cloudacademylabs.com"
}

variable "external_port" {
  description = "Gitea external port"
  type        = number
  default     = 3000
}

variable "ssh_port" {
  description = "Gitea SSH port"
  type        = number
  default     = 222
}

variable "token_port" {
  description = "Gitea token port"
  type        = number
  default     = 3001
}

variable "key_pair_name" {
  description = "Key pair name"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
}

variable "volume_size" {
  description = "Root volume size"
  type        = number
  default     = 50
}

variable "docker_version" {
  description = "Docker version in the DNF repository"
  type        = string
  default     = "docker-25.0.6-1.amzn2023.0.1.x86_64"
}

variable "runner_binary_url" {
  description = "URL to download the runner binary"
  type        = string
  default     = "https://assets.labs.platform.qa.com/terraform-module-aws-gitea/act_runner-0.2.10-linux-amd64"
}

variable "runner_image" {
  description = "Docker image used by the gitea runner when running jobs"
  type        = string
  default     = "public.ecr.aws/cloudacademy-labs/cloudacademy/labs/gitea-runner-ubuntu"
}

variable "gitea_role_managed_policies" {
  description = "List of ARNs of managed policies to attach to the Gitea role"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
}

variable "create_runner" {
  description = "Create a runner"
  type        = bool
  default     = false
}
