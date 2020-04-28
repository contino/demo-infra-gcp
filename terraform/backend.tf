terraform {
  backend "gcs" {
    credentials = "account.json"
    bucket = "demo-tfstate-eu-gcs"
    prefix = "terraform"
  }
}
