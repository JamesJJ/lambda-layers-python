locals {
  lambda_layer_dir = var.lambda_layer_dir == "" ? "${path.module}/layer" : var.lambda_layer_dir
}

resource "aws_lambda_layer_version" "boto3_botocore_requests" {
  filename                 = "${local.lambda_layer_dir}/package.zip"
  source_code_hash         = filebase64sha256("${local.lambda_layer_dir}/package.zip")
  layer_name               = "boto3_botocore_requests"
  compatible_runtimes      = ["python3.11", "python3.10", "python3.9"]
  compatible_architectures = ["arm64", "x86_64"]
}

output "boto3_botocore_requests_arn" {
  value = aws_lambda_layer_version.boto3_botocore_requests.arn
}
