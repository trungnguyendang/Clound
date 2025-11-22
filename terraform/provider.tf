terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "root-clover-478414-j5"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-b"
}
