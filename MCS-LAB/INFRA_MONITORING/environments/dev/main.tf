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

module "cloudwatch_agent" {
  source = "../../modules/cloudwatch-agent"

  application_name = var.application_name
  environment      = var.environment
  region           = var.aws_region
}

module "ec2" {
  source = "../../modules/ec2"

  application_name = var.application_name
  environment      = var.environment

  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  security_group_id = module.linux_server_sg.security_group_id.id

  instance_profile_name = module.iam.instance_profile_name

  common_tags = local.common_tags

  user_data = module.cloudwatch_agent.user_data
}
module "cloudwatch_alarms" {
  source = "../../modules/cloudwatch-alarms"

  application_name              = var.application_name
  unique_application_identifier = "swiftchange"
  environment                   = var.environment

  instance_id = module.ec2.instance_id

  namespace = "${var.application_name}/${var.environment}"

  cpu_threshold        = 80
  memory_threshold     = 80
  filesystem_threshold = 80
  swap_threshold       = 50
}