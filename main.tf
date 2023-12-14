locals {
  lambda_layer_dir = var.lambda_layer_dir == "" ? "${path.module}/layer" : var.lambda_layer_dir
}

resource "aws_lambda_layer_version" "boto3_botocore_requests" {
  filename                 = "${local.lambda_layer_dir}/package.zip"
  source_code_hash         = filebase64sha256("${local.lambda_layer_dir}/package.zip")
  layer_name               = "boto3_botocore_requests"
  compatible_runtimes      = var.compatible_runtimes
  compatible_architectures = var.compatible_architectures
}

output "boto3_botocore_requests_arn" {
  value = aws_lambda_layer_version.boto3_botocore_requests.arn
}
