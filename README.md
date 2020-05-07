# Scaffolding Pipeline GCP

## Building Infrastructure Platform

![Cloud Architecture](images/GCP-GKE-Infra.jpeg)

- This will create a VPC and subnet
- This will create a GKE regional (default: europe-west1) cluster (default name: demo-application) with a nodepool
- This will create necessary service accounts
- This will create container registry (GCR)
- This will create a secret "gcr-json-key" for docker image for deployments
- This repo's Dockerfile is used to create image (japrakash/cci-terraform-light-gcloudsdk:0.0.1) with terraform and gcloud sdk

## Getting Started

1) Find out a GCP project or create a new one and then create a bucket e.g. "demo-tfstate-eu-gcs" for saving terraform state.

2) Create a service account "terraform" which will be used to run pipeline. Download its key file in json format.

3) Create env variable GCP_CREDS in CircleCI project having value from step 2.

4) Change project_id field in terraform.tfvars.

5) Let the pipeline run and that should create complete infra.
