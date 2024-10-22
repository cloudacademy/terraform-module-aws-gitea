data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

data "http" "auth_token" {
  depends_on = [aws_instance.gitea]

  method   = "GET"
  insecure = true
  url      = "http://${aws_instance.gitea.public_ip}:${var.token_port}/token"
}

