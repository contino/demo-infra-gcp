terraform {
  backend "gcs" {
    bucket = "demo-application-tfstate-eu-gcs"
    prefix = "terraform"
  }
}

