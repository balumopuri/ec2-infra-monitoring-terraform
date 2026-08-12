resource "aws_security_group" "linux_server_sg" {

  name        = "${var.application_name}-${var.environment}-linux-sg"
  description = "Security Group for Linux Monitoring Servers"
  vpc_id      = var.vpc_id

  tags = merge(
    var.common_tags,
    {
      Name = "${var.application_name}-${var.environment}-linux-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {

  security_group_id = aws_security_group.linux_server_sg.id

  description = "Allow SSH"

  from_port = 22

  to_port = 22

  ip_protocol = "tcp"

  cidr_ipv4 = var.ssh_allowed_cidr

}

resource "aws_vpc_security_group_ingress_rule" "ec2_instance_connect" {

  security_group_id = aws_security_group.linux_server_sg.id

  description = "Allow SSH from EC2 Instance Connect (browser-based console SSH)"

  from_port = 22

  to_port = 22

  ip_protocol = "tcp"

  cidr_ipv4 = var.ec2_instance_connect_cidr

}

resource "aws_vpc_security_group_egress_rule" "all_outbound" {

  security_group_id = aws_security_group.linux_server_sg.id

  ip_protocol = "-1"

  cidr_ipv4 = "0.0.0.0/0"

  description = "Allow All Outbound"

}


