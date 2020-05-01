data "google_client_config" "current" {
}

data "google_container_engine_versions" "versions" {
  provider       = google-beta
  version_prefix = "1.14."
  location       = "europe-west1-b"
}

