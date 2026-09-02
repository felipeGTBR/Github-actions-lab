resource "aws_cognito_user_pool_domain" "prefeitura-url" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.login.id
}