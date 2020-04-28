module "kubernetes-engine_example_safer_cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//examples/safer_cluster"
  version = "8.1.0"
  compute_engine_service_account = "circleci@kubernetes-cp.iam.gserviceaccount.com"
  project_id = "kubernetes-cp"
  region = "europe-west1"
}