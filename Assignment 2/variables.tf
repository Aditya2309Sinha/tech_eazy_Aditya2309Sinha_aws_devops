```hcl
variable "aws_region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  description = "AMI to use"
}

variable "key_name" {
  description = "SSH key name"
}

variable "bucket_name" {
  description = "S3 bucket name"
}

variable "env" {
  description = "Deployment environment"
  default     = "dev"
}
```
