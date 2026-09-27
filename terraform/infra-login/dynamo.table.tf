resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb_table.name
  billing_mode = var.dynamodb_table.billing_mode
  hash_key     = var.dynamodb_table.hash_key
  point_in_time_recovery {
    enabled = var.dynamodb_table.point-in-time-recovery
  }
  server_side_encryption {
  #checkov:skip=CKV_AWS_119: não precisa de CMK no dynamodb, pois ele só é utilizado como state locking
    enabled = var.dynamodb_table.server-side-encryption
  }

  attribute {
    name = var.dynamodb_table.hash_key
    type = var.dynamodb_table.hash_key_type
  }
}