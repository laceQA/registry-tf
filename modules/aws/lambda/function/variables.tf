variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for Lambda execution"
}

variable "handler" {
  type        = string
  description = "Lambda handler (e.g., index.handler)"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime (e.g., nodejs18.x, python3.10)"
}

variable "filename" {
  type        = string
  description = "Path to the deployment package zip file"
}