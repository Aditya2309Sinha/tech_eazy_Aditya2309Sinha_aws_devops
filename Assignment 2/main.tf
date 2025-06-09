```hcl
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  security_groups      = [aws_security_group.ec2_sg.name]

  user_data = file("user_data.sh")

  tags = {
    Name = "AppEC2-${var.env}"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg-${var.env}"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```
