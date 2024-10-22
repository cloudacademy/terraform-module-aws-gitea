locals {
  user_data = templatefile("${path.module}/templates/user-data.sh.tftpl", {
    docker  = { version = var.docker_version, image = var.image },
    app_ini = local.app_ini_config,
    user    = { name = var.username, password = var.password, email = var.email },
    ports   = { ssh = var.ssh_port, external = var.external_port, token = var.token_port },
    runner = {
      create     = var.create_runner,
      image      = var.runner_image,
      binary_url = var.runner_binary_url,
      config     = local.runner_config,
    },
  })
  app_ini_config = templatefile("${path.module}/templates/app.ini.tftpl", {
    ports = { ssh = var.ssh_port, external = var.external_port },
  })
  runner_config = templatefile("${path.module}/templates/runner-config.yaml.tftpl", {
    image = var.runner_image
  })
}