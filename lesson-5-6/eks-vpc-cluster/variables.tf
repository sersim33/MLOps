variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "vpc_name" {
  type    = string
  default = "eks-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["eu-central-1a","eu-central-1b","eu-central-1c"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]
}

variable "cluster_name" {
  type    = string
  default = "eks-cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.28"
}

variable "node_groups" {
  type = map(any)
  default = {
    cpu = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
    gpu = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_type    = "g4dn.xlarge"
    }
  }
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Project     = "eks-vpc-cluster"
  }
}




