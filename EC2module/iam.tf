resource "aws_iam_role" "this" {
  name = format("ec2-s3-limited-access-role-%s-%s", var.environment, var.region_alias)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Custom policy for limited S3 access
resource "aws_iam_policy" "s3_read_only_policy" {
  name        = format("S3ReadOnlyPolicy-%s-%s", var.environment, var.region_alias)
  description = "Allow list, read, and get permissions on the specified S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:Get*",
          "s3:Put*"
        ]
        Resource = [
          var.s3_bucket_arn,
          "${var.s3_bucket_arn}/*"
        ]
      }
    ]
  })
}

# Attach the custom S3 read-only policy to the IAM role
resource "aws_iam_role_policy_attachment" "s3_read_only_attachment" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.s3_read_only_policy.arn
}

# Instance profile for the EC2 instance to assume the IAM role
resource "aws_iam_instance_profile" "this" {
  name = format("ec2-instance-profile-%s-%s", var.environment, var.region_alias)
  role = aws_iam_role.this.name
}
