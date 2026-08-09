locals {
  cloudwatch_agent_config = jsonencode({
    agent = {
      metrics_collection_interval = 60
      run_as_user                  = "root"
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
          totalcpu                     = true
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
        # CROND
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

            pid_finder = "native"
          },

          # =========================
          # CHRONYD
          # =========================
          {
            pattern = "chronyd"

            measurement = [
              "pid_count",
              "cpu_usage",
              "memory_rss"
            ]

            metrics_collection_interval = 60

            pid_finder = "native"
          }
        ]
      }
    }
  })
}