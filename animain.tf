terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.65.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "my_server" {
  ami           = "ami-00d8aa800578d8b12"   
  instance_type = "t3.micro"

  tags = {
    Name        = "MyServerName12"  
    Environment = "Dev"
    Owner       = "Aniket"
  }
}
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "aniket-demo-bucket-123"   # must be globally unique

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_public_access_block" "my_bucket_block" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
