variable "endpoint_name" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "s3_model_path" {
  description = "S3 path where multiple models are stored"
  type        = string
}

variable "image" {
  type    = string
  default = "763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-inference:1.13-cpu-py39"
}

variable "instance_type" {
  type    = string
  default = "ml.t2.medium"
}