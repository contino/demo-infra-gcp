provider "google" {
  credentials = "account.json"
  project     = "kubernetes-cp"
  region      = "europe-west1"
}

provider "google-beta" {
  credentials = "account.json"
  project     = "kubernetes-cp"
  region      = "europe-west1"
}