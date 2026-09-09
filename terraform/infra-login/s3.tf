resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket.name
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.s3_bucket.versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "secret/aws/s3"
      sse_algorithm     = "AES256"
    }
  }
}