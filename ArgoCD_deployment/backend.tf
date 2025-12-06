terraform {
  backend "s3" {
    bucket  = "mlops-tfstate-sergii-eu"
    key     = "ArgoCD_deployment/terraform.tfstate"
    region  = "eu-central-1"
    profile = "admin"
  }
}