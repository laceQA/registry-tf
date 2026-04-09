variable "model_name" {
  description = "Name of the SageMaker model"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the SageMaker endpoint"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role ARN for SageMaker"
  type        = string
}

variable "model_id" {
  description = "HuggingFace model ID"
  type        = string
  default     = "distilbert-base-uncased-finetuned-sst-2-english"
}

variable "image" {
  description = "Container image for inference"
  type        = string
  default     = "763104351884.dkr.ecr.us-east-1.amazonaws.com/pytorch-inference:1.13-cpu-py39"
}

variable "instance_type" {
  description = "Instance type for endpoint"
  type        = string
  default     = "ml.t2.medium"
}

variable "endpoint_config_name" {
  description = "Optional custom endpoint config name"
  type        = string
  default     = null
}