terraform {
  required_version = "~> 0.12"
}

provider "aws" {
  version = "~> 2.48"

  region = local.aws_region
}
