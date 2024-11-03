# Security Group for EC2 Instance with HTTP access
resource "aws_security_group" "this" {
  name        = format("ec2-security-group-%s-%s", var.environment, var.region_alias)
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance with IAM instance profile, security group, and user data to install IIS
resource "aws_instance" "this" {
  ami                        = var.ec2_ami
  subnet_id                  = var.ec2_subnet_id
  vpc_security_group_ids     = [aws_security_group.this.id]
  iam_instance_profile       = aws_iam_instance_profile.this.name
  instance_type              = var.ec2_instance_type
  associate_public_ip_address = true  # Enable public IP
  ebs_optimized              = false

  # PowerShell script to install IIS and serve "Hello world!" on a Windows server
  user_data = <<-EOF
    <powershell>
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    $htmlContent = @"
    <html>
      <head>
        <title>Hello World</title>
      </head>
      <body>
        <h1>Hello World!</h1>
        <p>Welcome to my Windows web server!</p>
      </body>
    </html>
    "@
    $htmlContent | Out-File -FilePath "C:\\inetpub\\wwwroot\\index.html" -Encoding utf8
    Restart-Service -Name W3SVC
    </powershell>
  EOF

  root_block_device {
    volume_type = "gp3"
    volume_size = var.ec2_volume_size
  }

  tags = {
    Name        = format("ec2-%s-%s", var.environment, var.region_alias)
    Environment = var.environment
  }
}
