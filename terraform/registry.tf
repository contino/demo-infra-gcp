resource "google_service_account" "container-registry-user" {
  account_id   = "container-registry-user"
  display_name = "Used by CICD to push and pull to/from GCR"
  project      = var.project_id
}

resource "google_storage_bucket_iam_member" "container-registry-user" {
  bucket = "eu.artifacts.${data.google_project.container-images.project_id}.appspot.com"
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.container-registry-user.email}"
}

resource "google_service_account_key" "container-registry-user" {
  service_account_id = google_service_account.container-registry-user.name
}

resource "kubernetes_secret" "container-reader-writer" {
  provider = kubernetes

  metadata {
    name      = "gcr-json-key"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = "${base64decode(google_service_account_key.container-registry-user.private_key)}"
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "google_container_registry" "registry" {
  project  = var.project_id
  location = "EU"
}

data "google_project" "container-images" {
  project_id = var.project_id
}

locals {
  gcr_bucket_name = "eu.artifacts.${data.google_project.container-images.name}.appspot.com"
}

