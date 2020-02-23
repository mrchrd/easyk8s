terraform {
  required_version = "~> 0.12"
}

provider "google" {
  version = "~> 3.8"

  region = local.gcp_region
}
