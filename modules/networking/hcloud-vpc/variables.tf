variable "network_name" {
  type        = string
  description = "Name of the VPC"
}

variable "developer_ssh_ip" {
  type        = string
  description = "Your public IP in CIDR format (e.g., 1.2.3.4/32)"
}
