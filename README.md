# Scaffolding Pipeline GCP

## Building Infrastructure Platform

![Cloud Architecture](images/GCP-GKE-Infra.jpeg)

Following resources would be created using this repo.

   1) VPC and subnet
   2) GKE regional cluster (default region: europe-west1, default name: demo-application) with a nodepool
   3) Relevant service accounts
   4) Container registry (GCR)
   5) Secret "gcr-json-key" for docker image pull access for deployments
   6) Static IP address
   7) Cloud DNS, DNS Zone with A type record set pointing to static IP
   7) nginx ingress-controller
   8) cert-manager and letsencrypt

- This repo's Dockerfile is used to create image (japrakash/cci-terraform-light-gcloudsdk:0.0.1) with terraform and gcloud sdk

## Getting Started

1) Find out a GCP project or create a new one and then create a bucket e.g. "demo-tfstate-eu-gcs" for saving terraform state.

2) Create a service account "cicd-pipeline" which will be used to run pipelines. Download its key file in json format and use as GCP_CREDS value.

3) Create below mentioned env variables in CircleCi with respective values
   
           CLUSTER_NAME = demo-application
           CLUSTER_REGION = europe-west1
           GCP_CREDS = <json file contents created in step 2>
           GCP_PROJECT = jagendra-atal-prakash-contino
           DNS_NAME = testmynewapplication.tk.

4) Let the pipeline run and that should create complete infra.

## TODO

1) PodSecurityPolicy (pod_security_policy_config) for cluster is currently disable. So need to enable it.

2) Automation of new project, terraform state bucket and service account creation
