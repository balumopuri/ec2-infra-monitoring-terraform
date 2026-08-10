resource "aws_iam_role" "cloudwatch_role" {

  name = "${var.application_name}-${var.environment}-cloudwatch-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {

  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

resource "aws_iam_instance_profile" "cloudwatch_profile" {

  name = "${var.application_name}-${var.environment}-instance-profile"

  role = aws_iam_role.cloudwatch_role.name

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.cloudwatch_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}