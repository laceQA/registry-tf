module "bucket" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/s3/bucket?ref=..."

  bucket = "test-bucket-sravani-123"
}

module "policy" {
  source = "git::https://github.com/lace-cloud/registry-tf.git//modules/aws/iam/policy?ref=..."

  policy_name = "test-policy"

  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "*"
        Resource = "*"
      }
    ]
  })
}