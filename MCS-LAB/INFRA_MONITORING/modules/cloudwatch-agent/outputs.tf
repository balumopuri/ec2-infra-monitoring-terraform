output "user_data" {
  value = <<-EOF
#!/bin/bash

set -e

echo "Installing Amazon CloudWatch Agent..."

dnf install -y amazon-cloudwatch-agent

mkdir -p /opt/aws/amazon-cloudwatch-agent/etc

cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'CONFIG'
${local.cloudwatch_agent_config}
CONFIG

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

systemctl enable amazon-cloudwatch-agent

systemctl status amazon-cloudwatch-agent --no-pager || true

echo "CloudWatch Agent installation completed."
EOF
}