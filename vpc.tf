# VPC for US region
module "vpc_america" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.14"

  for_each = toset(var.environments)

  providers = {
    aws = aws.america
  }

  name = format("us-%s-vpc", each.key)
  cidr = "10.10.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnets = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  enable_dns_support     = true
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    Name = format("us-%s-public", each.key)
  }
  
  private_subnet_tags = {
    Name = format("us-%s-private", each.key)
  }

  public_route_table_tags = {
    Name = format("us-%s-public-rt", each.key)
  }

  private_route_table_tags = {
    Name = format("us-%s-private-rt", each.key)
  }

  tags = {
    Name        = format("us-%s-vpc", each.key)
    Environment = each.key
  }
}

# VPC for Australia region
module "vpc_australia" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.14"

  for_each = toset(var.environments)

  providers = {
    aws = aws.australia
  }

  name = format("au-%s-vpc", each.key)
  cidr = "10.20.0.0/16"

  azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  public_subnets  = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  private_subnets = ["10.20.11.0/24", "10.20.12.0/24", "10.20.13.0/24"]

  enable_dns_support     = true
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    Name = format("au-%s-public", each.key)
  }
  
  private_subnet_tags = {
    Name = format("au-%s-private", each.key)
  }

  public_route_table_tags = {
    Name = format("au-%s-public-rt", each.key)
  }

  private_route_table_tags = {
    Name = format("au-%s-private-rt", each.key)
  }

  tags = {
    Name        = format("au-%s-vpc", each.key)
    Environment = each.key
  }
}

# VPC for England region
module "vpc_england" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.14"

  for_each = toset(var.environments)

  providers = {
    aws = aws.england
  }

  name = format("uk-%s-vpc", each.key)
  cidr = "10.30.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  public_subnets  = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
  private_subnets = ["10.30.11.0/24", "10.30.12.0/24", "10.30.13.0/24"]

  enable_dns_support     = true
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  public_subnet_tags = {
    Name = format("uk-%s-public", each.key)
  }
  
  private_subnet_tags = {
    Name = format("uk-%s-private", each.key)
  }

  public_route_table_tags = {
    Name = format("uk-%s-public-rt", each.key)
  }

  private_route_table_tags = {
    Name = format("uk-%s-private-rt", each.key)
  }

  tags = {
    Name        = format("uk-%s-vpc", each.key)
    Environment = each.key
  }
}
