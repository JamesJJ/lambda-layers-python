
variable "layers" {
  type = set(string)
  default = [
    # "aws_embedded_metrics",
    "boto3_botocore_requests",
    # "jmespath",
    # "idna",
  ]
}

variable "lambda_layer_dir" {
  type    = string
  default = ""
}

variable "compatible_runtimes" {
  default = ["python3.12", "python3.11"]
}

variable "compatible_architectures" {
  default = ["arm64", "x86_64"]
}

