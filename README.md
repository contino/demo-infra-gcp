# demo-infra-gcp
Infra for demo application using GCP

Find out a GCP project and then create a bucket "demo-tfstate-eu-gcs" for terraform state.

Create a service account "terraform" for terraform.

Create another service account "containerregistry" for container registry.

Create secret using container registry service account

kubectl create secret docker-registry gcr-json-key --docker-server=eu.gcr.io --docker-username=_json_key --docker-password="$(cat /Users/japrakash/Downloads/jagendra-atal-prakash-contino-b9e4ac7fe2dc.json)"          