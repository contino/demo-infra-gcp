terraform {
  backend "gcs" { 
    bucket      = "demo-tfstate-eu-gcs"
    prefix      = "terraform"
  }
}

