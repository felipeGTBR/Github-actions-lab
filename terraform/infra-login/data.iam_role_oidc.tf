data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid     = "permite assumir a role via OIDC do Github Actions"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.this.arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.trust_policy.github_repo}:ref:refs/heads/main"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "cognito-idp:CreateUserPool",
      "cognito-idp:CreateUserPoolClient",
      "cognito-idp:CreateUserPoolDomain",
      "cognito-idp:deleteUserPool",
      "cognito-idp:deleteUserPoolClient",
      "cognito-idp:deleteUserPoolDomain",
      "cognito-identity:createIdentityPool",
      "cognito-identity:deleteIdentityPool",
    ]
    resources = [
      "arn:aws:cognito-idp:&{data.aws_region.current.name}:&{data.aws_caller_identity.current.account_id}:userpool/&{var.cognito.name}",
      "arn:aws:cognito-identity:&{data.aws_region.current.name}:&{data.aws_caller_identity.current.account_id}:identitypool/&{var.cognito.name}",
    ]
  }
}