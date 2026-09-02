resource "aws_iam_role" "this" {
  name               = var.iam_role.name
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.iam_role.name}-policy"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.this.json
}