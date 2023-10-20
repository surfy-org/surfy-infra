terraform {
  backend "s3" {
    bucket = "surfy-terraform"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "aws" {
  region = "eu-west-3"
}
