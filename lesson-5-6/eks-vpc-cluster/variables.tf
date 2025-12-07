variable "aws_region" {
  default     = "eu-central-1"
  description = "AWS Region for EKS cluster"
}

variable "vpc_name" {
  default = "goit-vpc"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "azs" {
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "cluster_name" {
  default = "goit-eks"
}

variable "cluster_version" {
  default = "1.31"
}

variable "tags" {
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "node_groups" {
  default = {
    cpu_nodes = {
      instance_type = "t3.small"
      min_size      = 2
      max_size      = 3
      desired_size  = 2
    }
    extra_nodes = {
      instance_type = "t3.micro"
      min_size      = 2
      max_size      = 3
      desired_size  = 2
    }
  }
}






