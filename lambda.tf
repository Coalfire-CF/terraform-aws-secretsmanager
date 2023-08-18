resource "aws_lambda_function" "default" {
  description      = local.lambda_description
  filename         = "${path.module}/functions/${local.filename}"
  source_code_hash = filebase64sha256("${path.module}/functions/${local.filename}")
  function_name    = "${module.this.id}-password_rotation"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  timeout          = 30
  role             = aws_iam_role.default.arn
  vpc_config {
    subnet_ids         = var.subnets_lambda
    security_group_ids = var.security_group
  }
  environment {
    variables = { #https://docs.aws.amazon.com/general/latest/gr/rande.html#asm_region
      SECRETS_MANAGER_ENDPOINT = "https://secretsmanager.${data.aws_region.current.name}.amazonaws.com"
    }
  }
  tags = module.this.tags
}

resource "aws_lambda_permission" "default" {
  function_name = aws_lambda_function.default.function_name
  statement_id  = "AllowExecutionSecretManager"
  action        = "lambda:InvokeFunction"
  principal     = "secretsmanager.amazonaws.com"
}