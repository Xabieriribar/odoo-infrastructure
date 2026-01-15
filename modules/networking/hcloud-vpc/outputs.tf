output "vpc_id" {
  value       = hcloud_network.vpc.id
  description = "The ID of the VPC"
}

output "firewall_id" {
  value       = hcloud_firewall.production.id
  description = "The ID of the Firewall"
}
