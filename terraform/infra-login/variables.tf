variable "tags" {
  type = map(string)
  default = {
    "project" = "infraestrutura-login-prefeitura"
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "cognito" {
  type = object({
    name                = string
    region              = string
    username_attributes = list(string)
    mfa_configuration   = string

    password_policy = object({
      minimum_length    = number
      require_lowercase = bool
      require_numbers   = bool
      require_symbols   = bool
      require_uppercase = bool
    })
    auto_verified_attributes = list(string)
  })
  default = {
    name                = "login-prefeitura"
    region              = "us-east-1"
    username_attributes = ["email"]
    mfa_configuration   = "OFF"

    password_policy = {
      minimum_length    = 6
      require_lowercase = false
      require_numbers   = false
      require_symbols   = false
      require_uppercase = false
    }
    auto_verified_attributes = ["email"]
  }
}

variable "domain" {
  type    = string
  default = "login-prefeitura-digital-gov"
}

variable "app_client" {
  type = object({
    name          = string
    callback_urls = list(string)
    logout_urls   = list(string)

    allowed_oauth_flows_user_pool_client = bool
    allowed_oauth_flows                  = list(string)
    allowed_oauth_scopes                 = list(string)
    supported_identity_providers         = list(string)
  })
  default = {
    name = "autenticacao-prefeitura"

    callback_urls                        = ["https://prefeitura-digital-g8-aponti.github.io/grupo8-prefeitura/callback.html"]
    logout_urls                          = ["https://prefeitura-digital-g8-aponti.github.io/grupo8-prefeitura/index.html"]
    allowed_oauth_flows_user_pool_client = true
    allowed_oauth_flows                  = ["code", "implicit"]
    allowed_oauth_scopes                 = ["email", "openid"]
    supported_identity_providers         = ["COGNITO"]
  }
}

variable "iam_role" {
  type = object({
    name = string
  })
  default = {
    name = "github-actions-role"
  }
}

# utilizando um repositorio de testes para validar se tudo está funcionando corretamente antes de liberar para o repositório principal. (por isso o github_repo_teste)
variable "trust_policy" {
  type = object({
    description = string
    github_repo = string
    github_repo_teste = string
  })
  default = {
    description = "Permite que apenas o repositório do GitHub Actions da prefeitura possa assumir a role"
    github_repo = "prefeitura-digital-g8-aponti/grupo8-prefeitura"
    github_repo_teste = "felipeGTBR/Github-actions-lab" # utilizando um repositorio de testes para validar se tudo está funcionando corretamente antes de liberar para o repositório principal. (por isso o github_repo_teste)
  }
}

variable "s3_bucket" {
  type = object({
    name       = string
    versioning = string
  })
  default = {
    name       = "remote-backend-login-prefeitura-digital"
    versioning = "Enabled"
  }

  validation {
    condition     = var.s3_bucket.versioning == "Enabled"
    error_message = "O versionamento do remote bucket tem que estar habilitado."
  }
}

variable "dynamodb_table" {
  type = object({
    name          = string
    billing_mode  = string
    hash_key      = string
    hash_key_type = string
    point-in-time-recovery = bool
    server-side-encryption = bool
  })
  default = {
    name          = "LockTable-Login-Prefeitura"
    billing_mode  = "PAY_PER_REQUEST"
    hash_key      = "LockId"
    hash_key_type = "S"
    point-in-time-recovery = true #ou enabled (caso de erro no true), para habilitar o point-in-time-recovery
    server-side-encryption = true
  }
}