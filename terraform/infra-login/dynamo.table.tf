resource "aws_dynamodb_table" "this" {
  name         = var.dynamodb_table.name
  billing_mode = var.dynamodb_table.billing_mode
  hash_key     = var.dynamodb_table.hash_key

  attribute {
    name = var.dynamodb_table.hash_key
    type = var.dynamodb_table.hash_key_type
  }
}