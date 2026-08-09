data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "this" {
  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  user_data = var.user_data

  user_data_replace_on_change = true

  tags = merge(
    var.common_tags,
    {
      Name = "${var.application_name}-${var.environment}-server"
    }
  )
}