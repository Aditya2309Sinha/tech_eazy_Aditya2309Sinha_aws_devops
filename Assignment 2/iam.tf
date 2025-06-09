```hcl
resource "aws_iam_role" "s3_readonly" {
  name = "S3ReadOnlyRole"

  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ]
}

resource "aws_iam_role" "s3_writeonly" {
  name = "S3WriteOnlyRole"

  assume_role_policy = data.aws_iam_policy_document.assume_ec2.json
}

resource "aws_iam_policy" "writeonly_policy" {
  name = "S3WriteOnlyPolicy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:PutObject", "s3:CreateBucket"],
        Resource = "*"
      },
      {
        Effect = "Deny",
        Action = ["s3:GetObject"],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "writeonly_attachment" {
  role       = aws_iam_role.s3_writeonly.name
  policy_arn = aws_iam_policy.writeonly_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.s3_writeonly.name
}

data "aws_iam_policy_document" "assume_ec2" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
```
