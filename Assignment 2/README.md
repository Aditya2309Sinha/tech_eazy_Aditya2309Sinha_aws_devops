# EC2 Automation with S3 Log Archival (Terraform)

## Overview
This project automates the provisioning of an EC2 instance on AWS using Terraform, deploys a sample Java application, and uploads system & application logs to an S3 bucket. It also demonstrates role-based S3 permissions and S3 lifecycle rules for auto-deletion.

## Features
- EC2 instance provisioning
- IAM Roles for S3 (read-only and write-only)
- Private S3 bucket with lifecycle rule
- Application auto-deployment on EC2
- Upload logs to S3 after shutdown

## Prerequisites
- AWS CLI configured
- Terraform installed (>= v1.0)
- AWS IAM user with EC2 and S3 permissions

### Run Terraform
- terraform init
- terraform plan
- terraform apply -auto-approve


### Destroy Resources
terraform destroy -auto-approve

### Edit terraform.tfvars:
  ## Replace:
    - your-keypair-name with your existing AWS EC2 key pair
    - your-unique-s3-bucket-name with a globally unique name (or it will error) 

#### Replace `<your-username>/<your-repo>` in `user_data.sh`
