variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "policy_document" {
  description = "The IAM policy document (JSON string)"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the IAM policy"
  type        = map(string)
  default     = {}
}
