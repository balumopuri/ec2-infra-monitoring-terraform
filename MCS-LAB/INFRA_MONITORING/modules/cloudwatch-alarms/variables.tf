variable "application_name" {
  description = "Application name"
  type        = string
}

variable "unique_application_identifier" {
  description = "Unique application identifier used in alarm naming"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "instance_id" {
  description = "EC2 instance ID"
  type        = string
}

variable "namespace" {
  description = "CloudWatch Agent metric namespace"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU utilization alarm threshold"
  type        = number
  default     = 80
}

variable "memory_threshold" {
  description = "Memory utilization alarm threshold"
  type        = number
  default     = 80
}

variable "filesystem_threshold" {
  description = "Filesystem utilization alarm threshold"
  type        = number
  default     = 80
}

variable "swap_threshold" {
  description = "Swap utilization alarm threshold"
  type        = number
  default     = 50
}