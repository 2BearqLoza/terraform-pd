module "ec2_america" {
  for_each = toset(var.environments)

  source = "./EC2module"

  providers = {
    aws = aws.america
  }

  environment    = each.key
  region_alias   = "america"
  vpc_id         = module.vpc_america[each.key].vpc_id
  ec2_ami        = data.aws_ami.latest_amazon_windows_america.id
  ec2_subnet_id  = element(module.vpc_america[each.key].public_subnets, 0)
  s3_bucket_arn  = aws_s3_bucket.powerdiary[each.key].arn
}

module "ec2_australia" {
  for_each = toset(var.environments)

  source = "./EC2module"

  providers = {
    aws = aws.australia
  }

  environment    = each.key
  region_alias   = "australia"
  vpc_id         = module.vpc_australia[each.key].vpc_id
  ec2_ami        = data.aws_ami.latest_amazon_windows_australia.id
  ec2_subnet_id  = element(module.vpc_australia[each.key].public_subnets, 0)
  s3_bucket_arn  = aws_s3_bucket.powerdiary[each.key].arn
}

module "ec2_england" {
  for_each = toset(var.environments)

  source = "./EC2module"

  providers = {
    aws = aws.england
  }

  environment    = each.key
  region_alias   = "england"
  vpc_id         = module.vpc_england[each.key].vpc_id
  ec2_ami        = data.aws_ami.latest_amazon_windows_england.id
  ec2_subnet_id  = element(module.vpc_england[each.key].public_subnets, 0)
  s3_bucket_arn  = aws_s3_bucket.powerdiary[each.key].arn
}
