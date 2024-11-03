# Default AWS provider
provider "aws" {
  region  = "us-east-1"
  profile = var.profile
}

# Regional providers
provider "aws" {
  alias   = "america"
  region  = "us-east-1"
  profile = var.profile
}

provider "aws" {
  alias   = "australia"
  region  = "ap-southeast-2"
  profile = var.profile
}

provider "aws" {
  alias   = "england"
  region  = "eu-west-2"
  profile = var.profile
}
