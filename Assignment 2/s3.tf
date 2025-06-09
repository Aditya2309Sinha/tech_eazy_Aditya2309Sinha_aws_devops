```hcl
resource "aws_s3_bucket" "log_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  lifecycle_rule {
    enabled = true
    prefix  = ""
    expiration {
      days = 7
    }
  }
  force_destroy = true
}
```
