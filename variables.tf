variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "aws-vpc"
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "autoscaling_app"
}

