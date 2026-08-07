variable "application_name" {
    description = "Application Name"
    type = string
}

variable "environment" {
    description = "Environment Name"
    type = string
}

variable "common_tags" {
    description = "Standard Tags"
    type = map(string)
}

