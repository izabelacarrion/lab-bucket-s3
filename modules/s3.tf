resource "aws_s3_bucket" "lab-bucket" {
  count  = (var.environment == "izac_srv_prod" || var.environment == "izac_srv_stag") ? 1 : 0
  bucket = var.environment

  tags = {
    Name        = var.environment
    Environment = var.environment
  }
}