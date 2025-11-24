data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "mlops-tfstate-sergii-eu"
    key    = "vpc/terraform.tfstate"
    region = "eu-central-1"
  }
}
