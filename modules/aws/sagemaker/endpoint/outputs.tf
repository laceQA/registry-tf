output "endpoint_name" {
  description = "SageMaker endpoint name"
  value       = aws_sagemaker_endpoint.this.name
}

output "endpoint_arn" {
  description = "SageMaker endpoint ARN"
  value       = aws_sagemaker_endpoint.this.arn
}