# Terraform Multi-Region Infrastructure Deployment with EC2 and S3

This setup is designed for a single AWS account, where both "Testing" and "Production" environments will run. In real-world scenarios, two AWS accounts are preferable of course, for the logical segregation of resources.

This Terraform configuration deploys a multi-region AWS infrastructure that includes the following:

* Complete VPC networking, using the oficial VPC module including subnets, Internet and NAT gateways, route tables, etc. Custom module could have been used, but the official one provides all the benefits, without having to create an extensive module yourself.

* EC2 Instances: Windows-based servers are deployed across three AWS regions (us-east-1, ap-southeast-2, and eu-west-2), with instances in both Testing and Production environments. Note that the EBS volume is 30GB, which is the required minimum. Each instance runs IIS to serve a "Hello World!" web page.
EC2 instances have read/write permissions for the S3 buckets, via IAM Roles.
These instances are part of the custom module, and instantiated in each region - the reasoning is, this is a resource that is deployed multiple times.

* S3 Buckets: Two S3 buckets (one for each environment: Testing and Production) are created in the us-east-1 region, with server-side encryption (AES256) and public access block settings enabled. Bucket policy allows EC2 instances read/write access - EC2 instances from the "Testing" env are allowed to "Testing" bucket, and "Production" EC2 instances are allowed to the "Production" bucket.



Usage

The providers are set with "profile = var.profile", so that the AWS variable can be set with the desired profile and utilized for the deployment of resources. For example, if your AWS profile (the one you intend to use) is set in the AWS configuration file as "[profile my-profile]", you would initiate required terraform command like 'terraform plan -var="profile=my-profile"'.

Initialize: Run terraform init to initialize the working directory.

Deploy: Use terraform apply to deploy resources.

Access the Web Server: Once deployed, each EC2 instance serves a "Hello World!" page on a public IP, on port 80.

Outputs.tf provides public IP addresses of the Windows instances in each region, so that they can be accessed without having to get that information via AWS CLI or AWS Web UI.