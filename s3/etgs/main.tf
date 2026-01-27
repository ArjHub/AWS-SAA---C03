terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.18.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # or your preferred region
}

resource "aws_s3_bucket" "default" {
  # optional: specify a bucket name, or AWS will auto-generate one
  # bucket = "my-example-bucket"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.default.bucket  
  key    = "my_file.txt"
  source = "./myfile.txt"
  etag   = filemd5("./myfile.txt")
}
