variable "model_name" {
  description = "Name of the SageMaker model"
  type        = string
}

variable "endpoint_name" {
  description = "Name of the SageMaker endpoint"
  type        = string
}

variable "model_id" {
  description = "HuggingFace model ID"
  type        = string
  default     = "distilbert-base-uncased-finetuned-sst-2-english"
}

variable "image" {
  description = "HuggingFace inference container image"
  type        = string
  default     = "763104351884.dkr.ecr.us-east-1.amazonaws.com/huggingface-pytorch-inference:latest"
}