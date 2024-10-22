output "base_url" {
  value = "http://${aws_instance.gitea.public_ip}:${var.external_port}/"
}

output "login_url" {
  value = "http://${aws_instance.gitea.public_ip}:${var.external_port}/user/login"
}

output "git_credentials_command" {
  value = <<EOF
git config --global user.email ${var.email}
git config --global user.name ${var.username}
git config --global credential.helper store
echo "http://${var.username}:${var.password}@${aws_instance.gitea.public_ip}:${var.external_port}" > ~/.git-credentials
EOF
}

output "username" {
  value = var.username
}

output "password" {
  value = var.password
}

output "server_ip" {
  value = aws_instance.gitea.public_ip
}

output "role_arn" {
  value = aws_iam_role.gitea.arn
}

output "auth_token" {
  value = data.http.auth_token.response_body
}
