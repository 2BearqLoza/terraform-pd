variable "environment" {
  type        = string
  description = "Environment for the EC2 instance"
}

variable "region_alias" {
  type        = string
  description = "Region alias (e.g., america, australia, england)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the EC2 instance"
}

variable "ec2_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "Type of the EC2 instance"
  default     = "t3.micro"
}

variable "ec2_subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
}

variable "ec2_volume_size" {
  type        = number
  description = "Size of EBS volume attached to the EC2 instance"
  default     = 30
}

variable "s3_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket with limited permissions"
}