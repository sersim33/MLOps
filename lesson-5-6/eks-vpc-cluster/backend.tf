terraform {
  backend "s3" {
    bucket = "mlops-tfstate-sergii-eu"
    key    = "eks-vpc-cluster/terraform.tfstate"
    region = "eu-central-1"
  }
}


