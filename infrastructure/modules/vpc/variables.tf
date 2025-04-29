variable "availability_zones" {
    description = "List of availability zones to use for the VPC"
    type        = list(string)
}


variable "private_subnets" {
    description = "List of private subnets to create in the VPC"
    type        = list(string)
}


variable "cluster_name" {
    description = "Name of the cluster"
    type        = string
}


variable "public_subnets" {
    description = "List of public subnets to create in the VPC"
    type        = list(string)
}


variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type        = string
}


variable "region" {
  description = "AWS region to create resources in"
  type        = string
  default     = "us-east-1"  # You can change this default value or pass it from the Terragrunt config
}
