resource "aws_s3_bucket" "my-s3-teraformDarko" {
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}