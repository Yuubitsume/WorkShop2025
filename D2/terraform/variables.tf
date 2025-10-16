variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-3" # Paris
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "pra-si"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0f5e8a042940de211" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "Name of the EC2 Key Pair to allow SSH access"
  type        = string
  default     = "my-key-pair"
}

