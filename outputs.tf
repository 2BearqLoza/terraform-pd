output "ec2_public_ips_us" {
  description = "Public IP addresses of EC2 instances in US region"
  value       = [for instance in module.ec2_america : instance.public_ip]
}

output "ec2_public_ips_au" {
  description = "Public IP addresses of EC2 instances in Australia region"
  value       = [for instance in module.ec2_australia : instance.public_ip]
}

output "ec2_public_ips_uk" {
  description = "Public IP addresses of EC2 instances in England region"
  value       = [for instance in module.ec2_england : instance.public_ip]
}
