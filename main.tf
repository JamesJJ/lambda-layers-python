locals {
  lambda_layer_dir = var.lambda_layer_dir == "" ? "${path.module}/layers" : var.lambda_layer_dir
}

resource "aws_lambda_layer_version" "this" {
  for_each                 = var.layers
  filename                 = "${local.lambda_layer_dir}/${each.value}/package.zip"
  source_code_hash         = filebase64sha256("${local.lambda_layer_dir}/${each.value}/package.zip")
  layer_name               = each.value
  compatible_runtimes      = var.compatible_runtimes
  compatible_architectures = var.compatible_architectures
}

output "boto3_botocore_requests_arn" {
  value = aws_lambda_layer_version.this["boto3_botocore_requests"].arn
}

