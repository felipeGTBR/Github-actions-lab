resource "aws_cognito_user_pool" "login" {
  name   = var.cognito.name
  region = var.cognito.region

  username_attributes = var.cognito.username_attributes
  mfa_configuration   = var.cognito.mfa_configuration

  password_policy {
    minimum_length    = var.cognito.password_policy.minimum_length
    require_lowercase = var.cognito.password_policy.require_lowercase
    require_numbers   = var.cognito.password_policy.require_numbers
    require_symbols   = var.cognito.password_policy.require_symbols
    require_uppercase = var.cognito.password_policy.require_uppercase
  }

  auto_verified_attributes = var.cognito.auto_verified_attributes
}