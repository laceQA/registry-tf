variable "name" {
  description = "A name tag for the listener rule"
  type        = string
  default     = ""
}

variable "listener_arn" {
  description = "The ARN of the listener to attach the rule to"
  type        = string
}

variable "priority" {
  description = "The priority for the rule (1–50000); unique per listener"
  type        = number
  default     = null
}

variable "host_headers" {
  description = "List of host header values to match"
  type        = list(string)
  default     = []
}

variable "path_patterns" {
  description = "List of path pattern values to match"
  type        = list(string)
  default     = []
}

variable "action_type" {
  description = "The type of action (forward, redirect, fixed-response)"
  type        = string
  default     = "forward"
}

variable "target_group_arn" {
  description = "The ARN of the target group for a forward action"
  type        = string
  default     = null
}

variable "redirect_port" {
  description = "The port to redirect to"
  type        = string
  default     = "443"
}

variable "redirect_protocol" {
  description = "The protocol to redirect to"
  type        = string
  default     = "HTTPS"
}

variable "redirect_status_code" {
  description = "The HTTP redirect status code (HTTP_301 or HTTP_302)"
  type        = string
  default     = "HTTP_301"
}

variable "fixed_response_content_type" {
  description = "The content type for a fixed-response action"
  type        = string
  default     = "text/plain"
}

variable "fixed_response_message_body" {
  description = "The message body for a fixed-response action"
  type        = string
  default     = null
}

variable "fixed_response_status_code" {
  description = "The HTTP status code for a fixed-response action"
  type        = string
  default     = "200"
}

variable "tags" {
  description = "A map of tags to assign to the listener rule"
  type        = map(string)
  default     = {}
}
