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

3) Create below mentioned env variables in CircleCi with respective values
   
           CLUSTER_NAME = demo-application
           CLUSTER_REGION = europe-west1
           GCP_CREDS = <jjson file contents created in step 2>
           GCP_PROJECT = jagendra-atal-prakash-contino

4) Change project_id field in terraform.tfvars.

5) Let the pipeline run and that should create complete infra.
