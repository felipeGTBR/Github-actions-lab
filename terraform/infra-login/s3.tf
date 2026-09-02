resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket.name
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.s3_bucket.versioning
  }
}
