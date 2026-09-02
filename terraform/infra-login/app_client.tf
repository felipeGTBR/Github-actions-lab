resource "aws_cognito_user_pool_client" "client_web" {
  name         = var.app_client.name
  user_pool_id = aws_cognito_user_pool.login.id

  callback_urls = var.app_client.callback_urls
  logout_urls   = var.app_client.logout_urls

  allowed_oauth_flows_user_pool_client = var.app_client.allowed_oauth_flows_user_pool_client
  allowed_oauth_flows                  = var.app_client.allowed_oauth_flows
  allowed_oauth_scopes                 = var.app_client.allowed_oauth_scopes
  supported_identity_providers         = var.app_client.supported_identity_providers
}