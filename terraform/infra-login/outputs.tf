output "cognito_user_pool_id" {
  value       = aws_cognito_user_pool.login.id
  description = "ID do User Pool criado do Cognito"
}

output "cognito_user_pool_client_id" {
  value       = aws_cognito_user_pool_client.client_web.id
  description = "ID do Client necessário no código do front-end para autenticação"
}

output "cognito_domain_url" {
  value = "https://${aws_cognito_user_pool_domain.prefeitura-url.domain}.auth.${var.region}.amazoncognito.com"
}
