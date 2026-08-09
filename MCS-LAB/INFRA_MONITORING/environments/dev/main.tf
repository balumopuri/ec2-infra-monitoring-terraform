module "iam" {
  source = "../../modules/iam"

  application_name = var.application_name
  environment      = var.environment

  common_tags = local.common_tags
}


module "linux_server_sg" {
  source = "../../modules/linux-server-sg"

  application_name = var.application_name
  environment      = var.environment

  vpc_id           = var.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr

  common_tags = local.common_tags
}