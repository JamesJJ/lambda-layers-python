variable "lambda_layer_dir" {
  type    = string
  default = ""
}

variable "compatible_runtimes" {
  default = ["python3.12", "python3.11", "python3.10", "python3.9"]
}

variable "compatible_architectures" {
  default = ["arm64", "x86_64"]
}

