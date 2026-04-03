resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn
  priority     = var.priority

  dynamic "condition" {
    for_each = length(var.host_headers) > 0 ? [1] : []
    content {
      host_header {
        values = var.host_headers
      }
    }
  }

  dynamic "condition" {
    for_each = length(var.path_patterns) > 0 ? [1] : []
    content {
      path_pattern {
        values = var.path_patterns
      }
    }
  }

  dynamic "action" {
    for_each = var.action_type == "forward" ? [1] : []
    content {
      type             = "forward"
      target_group_arn = var.target_group_arn
    }
  }

  dynamic "action" {
    for_each = var.action_type == "redirect" ? [1] : []
    content {
      type = "redirect"
      redirect {
        port        = var.redirect_port
        protocol    = var.redirect_protocol
        status_code = var.redirect_status_code
      }
    }
  }

  dynamic "action" {
    for_each = var.action_type == "fixed-response" ? [1] : []
    content {
      type = "fixed-response"
      fixed_response {
        content_type = var.fixed_response_content_type
        message_body = var.fixed_response_message_body
        status_code  = var.fixed_response_status_code
      }
    }
  }

  tags = merge(
    {
      Name = var.name
    },
    var.tags
  )

  lifecycle {
    precondition {
      condition     = length(var.host_headers) > 0 || length(var.path_patterns) > 0
      error_message = "At least one of host_headers or path_patterns must be provided."
    }
  }
}
