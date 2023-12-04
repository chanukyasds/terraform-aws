
terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "5.28.0"
    }
  }
  required_version = "~> 1.6.4"
}

provider "aws" {
  region        =  "eu-central-1"  # Specify your desired AWS region
  access_key    =  ""
  secret_key    =  ""
}