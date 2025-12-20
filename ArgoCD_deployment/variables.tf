variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "admin"
}

variable "eks_cluster_name" {
  description = "Ім'я існуючого EKS кластера"
  type        = string
  default     = "goit-eks" #додано
}


variable "aws_region" {
  description = "AWS region for AWS provider"
  type        = string
  default     = "eu-central-1"
}

variable "eks_state_bucket" {
  description = "S3 bucket з remote state EKS"
  type        = string
  default     = "mlops-tfstate-sergii-eu"
}

variable "eks_state_key" {
  description = "S3 key для remote state EKS"
  type        = string
  default     = "eks-vpc-cluster/terraform.tfstate"
}

variable "eks_state_region" {
  description = "Регіон бакета з remote state EKS"
  type        = string
  default     = "eu-central-1"
}

variable "argocd_namespace" {
  description = "Namespace для Argo CD"
  type        = string
  default     = "infra-tools" #infra-tools
}

variable "argocd_chart_version" {
  description = "Версія Helm-чарту Argo CD"
  type        = string
  default     = "v7.7.5"
}

variable "app_repo_url" {
  description = "Git repo URL"
  type        = string
  default     = "https://gitlab.com/sersim/aiops-quality-project.git"
}

variable "app_repo_branch" {
  description = "Branch to use"
  type        = string
  default     = "main"
}
