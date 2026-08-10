locals {

  # ==========================================================
  # CloudWatch Agent Configuration
  # ==========================================================

  cloudwatch_agent_config = jsonencode({

    agent = {
      metrics_collection_interval = 60
      run_as_user                 = "root"

      append_dimensions = {
        InstanceId   = "$${aws:InstanceId}"
        InstanceType = "$${aws:InstanceType}"
      }
    }

    metrics = {
      namespace = "${var.application_name}/${var.environment}"

      metrics_collected = {

        # =========================
        # CPU
        # =========================
        cpu = {
          measurement = [
            "cpu_usage_idle",
            "cpu_usage_user",
            "cpu_usage_system"
          ]

          metrics_collection_interval = 60
          totalcpu                    = true
        }

        # =========================
        # MEMORY
        # =========================
        mem = {
          measurement = [
            "mem_used_percent"
          ]

          metrics_collection_interval = 60
        }

        # =========================
        # SWAP
        # =========================
        swap = {
          measurement = [
            "swap_used_percent"
          ]

          metrics_collection_interval = 60
        }

        # =========================
        # FILESYSTEM
        # =========================
        disk = {
          measurement = [
            "used_percent"
          ]

          resources = [
            "*"
          ]

          metrics_collection_interval = 60

          ignore_file_system_types = [
            "sysfs",
            "devtmpfs",
            "devpts",
            "tmpfs",
            "proc",
            "proc4",
            "overlay",
            "squashfs"
          ]
        }

        # =========================
        # DISK I/O
        # =========================
        diskio = {
          measurement = [
            "diskio_reads",
            "diskio_writes"
          ]

          metrics_collection_interval = 60
        }

        # =========================
        # PROCESS MONITORING
        # =========================
        procstat = [
          {
            pattern = "crond"

            measurement = [
              "pid_count",
              "cpu_usage",
              "memory_rss"
            ]

            metrics_collection_interval = 60
            pid_finder                  = "native"
          },

          {
            pattern = "chronyd"

            measurement = [
              "pid_count",
              "cpu_usage",
              "memory_rss"
            ]

            metrics_collection_interval = 60
            pid_finder                  = "native"
          }
        ]
      }
    }
  })


  # ==========================================================
  # EC2 Bootstrap Script
  # ==========================================================

  user_data = <<-EOF
    #!/bin/bash

    set -e

    echo "===== Starting server bootstrap ====="

    # ========================================================
    # 1. Configure SSM Agent
    # ========================================================

    echo "===== Configuring SSM Agent ====="

    if systemctl list-unit-files | grep -q "amazon-ssm-agent.service"; then
        echo "SSM Agent already installed"
    else
        echo "SSM Agent not found. Installing..."

        dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
    fi

    systemctl enable amazon-ssm-agent
    systemctl start amazon-ssm-agent

    echo "SSM Agent status:"
    systemctl --no-pager status amazon-ssm-agent || true


    # ========================================================
    # 2. Install CloudWatch Agent
    # ========================================================

    echo "===== Installing CloudWatch Agent ====="

    dnf install -y amazon-cloudwatch-agent


    # ========================================================
    # 3. Create CloudWatch Agent Configuration
    # ========================================================

    echo "===== Creating CloudWatch Agent configuration ====="

    cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json <<'CONFIG'
    ${local.cloudwatch_agent_config}
    CONFIG

# ========================================================
# 4. Start CloudWatch Agent
# ========================================================

echo "===== Starting CloudWatch Agent ====="

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config \
  -m ec2 \
  -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
  -s

systemctl enable amazon-cloudwatch-agent

echo "CloudWatch Agent status:"
systemctl --no-pager status amazon-cloudwatch-agent || true


    # ========================================================
    # 5. Final Status
    # ========================================================

    echo "===== Bootstrap completed ====="

    echo "SSM Agent:"
    systemctl is-active amazon-ssm-agent || true

    echo "CloudWatch Agent:"
    systemctl is-active amazon-cloudwatch-agent || true

  EOF
}