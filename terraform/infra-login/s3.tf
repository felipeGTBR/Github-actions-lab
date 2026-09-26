resource "aws_s3_bucket" "this" {
  #checkov:skip=CKV_AWS_18: este bucket é utilizado para armazenar o backend remoto do terraform, então não precisa do logging habilitado
  #checkov:skip=CKV_AWS_144: pelo mesmo motivo do comentário acima, não precisa do cross region replication habilitado
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

resource "aws_s3_bucket_public_access_block" "private-bucket" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.s3_bucket.public_access_block
  block_public_policy     = var.s3_bucket.public_access_block
  ignore_public_acls      = var.s3_bucket.public_access_block
  restrict_public_buckets = var.s3_bucket.public_access_block
}