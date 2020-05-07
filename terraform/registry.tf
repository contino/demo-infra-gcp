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

resource "google_service_account" "image-puller" {
  account_id   = "image-puller"
  display_name = "Image Puller"
}

resource "google_service_account_key" "image-puller" {
  service_account_id = google_service_account.image-puller.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "kubernetes_secret" "image-puller" {
  metadata {
    name      = "gcr-json-key"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      "auths" : {
        "https://gcr.io" : {
          email    = google_service_account.image-puller.email
          username = "_json_key"
          password = trimspace(base64decode(google_service_account_key.image-puller.private_key))
          auth     = base64encode(join(":", ["_json_key", base64decode(google_service_account_key.image-puller.private_key)]))
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}
