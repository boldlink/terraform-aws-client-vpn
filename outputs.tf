output "arn" {
  description = "The ARN of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.main.arn
}

output "dns_name" {
  description = "The DNS name to be used by clients when establishing their VPN session."
  value       = aws_ec2_client_vpn_endpoint.main.dns_name
}

output "id" {
  description = "The ID of the Client VPN endpoint."
  value       = aws_ec2_client_vpn_endpoint.main.id
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider."
  value       = aws_ec2_client_vpn_endpoint.main.tags_all
}

output "sg_arn" {
  description = "ARN of the security group."
  value       = aws_security_group.main.arn
}

output "sg_id" {
  description = "ID of the security group."
  value       = aws_security_group.main.id
}

output "owner_id" {
  description = "Owner ID"
  value       = aws_security_group.main.owner_id
}

output "log_group_arn" {
  description = "The Amazon Resource Name (ARN) specifying the log group"
  value       = aws_cloudwatch_log_group.main[0].arn
}
