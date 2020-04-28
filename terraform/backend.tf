terraform {
  backend "gcs" {
    bucket = "demo-tfstate-eu-gcs"
    prefix = "terraform/state-squadzero/"
    credentials = "account.json"
  }
}