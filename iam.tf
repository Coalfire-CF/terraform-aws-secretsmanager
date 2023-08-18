resource "aws_iam_role" "default" {
  name               = "${module.this.id}-password_rotation"
  assume_role_policy = data.aws_iam_policy_document.service.json
  tags               = module.this.tags
}

resource "aws_iam_role_policy_attachment" "lambda-basic" {
  role       = aws_iam_role.default.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationSingleUserRolePolicy0" {
  count  = var.rotation_type == "single" ? 1 : 0
  name   = "SecretsManagerRDSPgSQLRotationSingleUserRolePolicy0"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationSingleUserRolePolicy0.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationSingleUserRolePolicy1" {
  count  = var.rotation_type == "single" ? 1 : 0
  name   = "SecretsManagerRDSPgSQLRotationSingleUserRolePolicy1"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationSingleUserRolePolicy1.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationSingleUserRolePolicy2" {
  count  = var.rotation_type == "single" ? 1 : 0
  name   = "SecretsManagerRDSPgSQLRotationSingleUserRolePolicy2"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationSingleUserRolePolicy2.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy0" {
  count  = var.rotation_type == "single" ? 0 : 1
  name   = "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy0"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationMultiUserRolePolicy0.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy1" {
  count  = var.rotation_type == "single" ? 0 : 1
  name   = "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy1"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationMultiUserRolePolicy1.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy2" {
  count  = var.rotation_type == "single" ? 0 : 1
  name   = "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy2"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationMultiUserRolePolicy2.json
}

resource "aws_iam_role_policy" "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy4" {
  count  = var.rotation_type == "single" ? 0 : 1
  name   = "SecretsManagerRDSPgSQLRotationMultiUserRolePolicy4"
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.SecretsManagerRDSPgSQLRotationMultiUserRolePolicy4.json
}