resource "aws_s3_bucket" "lab-bucket" {
  bucket = "izac-projeto-${terraform.workspace}"

  tags = {
    Name        = terraform.workspace
    Environment = terraform.workspace
  }
}