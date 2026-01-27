resource "aws_s3_bucket" "S3Bucket" {

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}