terraform {
  backend "gcs" {
    bucket = "demo-application-tfstate-eu-gcs-${var.project_id}"
    prefix = "terraform"
  }
}

