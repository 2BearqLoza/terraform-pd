# Data source for latest Windows Server 2022 Core AMI in the US region
data "aws_ami" "latest_amazon_windows_america" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Core-Base-*"]
  }

  provider = aws.america
}

# Data source for latest Windows Server 2022 Core AMI in the Australian region
data "aws_ami" "latest_amazon_windows_australia" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Core-Base-*"]
  }

  provider = aws.australia
}

# Data source for latest Windows Server 2022 Core AMI in the UK region
data "aws_ami" "latest_amazon_windows_england" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Core-Base-*"]
  }

  provider = aws.england
}
