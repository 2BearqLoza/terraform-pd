resource "aws_s3_bucket" "powerdiary" {
  for_each = toset(var.environments)

  bucket = format("powerdiary-%s-bucket", lower(each.key))

  provider = aws.america

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = format("powerdiary-%s-bucket", each.key)
    Environment = each.key
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "powerdiary_sse" {
  for_each = aws_s3_bucket.powerdiary

  bucket = each.value.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "powerdiary_public_access" {
  for_each = aws_s3_bucket.powerdiary

  bucket = each.value.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_policy" "powerdiary_policy" {
  for_each = aws_s3_bucket.powerdiary

  bucket = each.value.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = [
            format("arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ec2-s3-limited-access-role-%s-america", each.key),
            format("arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ec2-s3-limited-access-role-%s-australia", each.key),
            format("arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/ec2-s3-limited-access-role-%s-england", each.key)
          ]
        }
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = [
          each.value.arn,
          "${each.value.arn}/*"
        ]
      }
    ]
  })
}

# Get the AWS account ID for dynamically generating ARNs
data "aws_caller_identity" "current" {}
