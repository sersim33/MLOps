
terraform {
  backend "s3" {
    bucket  = "mlops-terraform-goit"
    key     = "argocd/terraform.tfstate"
    region  = "eu-central-1""
    profile = "goit-terraform"
  }
}
