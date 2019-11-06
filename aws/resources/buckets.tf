terraform {
  backend "remote" {
    organization = "empathy"

    workspaces {
      name = "devfest-aws"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::XXXXXXXXXXX:role/Terraform"
  }
}
resource "random_id" "random" {
  keepers = {
    bucket = "${var.bucket_name}"
  }

  byte_length = 4
}
resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_name}-${random_id.random.dec}"
  acl    = "private"

  tags = {
    Name        = "${var.bucket_name}"
    Environment = "Test"
  }
}

