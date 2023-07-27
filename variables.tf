variable "name" {
  description = "Name must be 255 characters or less in length."
  type        = string
}

variable "client_cidr_block" {
  description = "(Required) The IPv4 address range, in CIDR notation, from which to assign client IP addresses. The address range cannot overlap with the local CIDR of the VPC in which the associated subnet is located, or the routes that you add manually. The address range cannot be changed after the Client VPN endpoint has been created. The CIDR block should be /22 or greater."
  type        = string
}

variable "description" {
  description = "(Optional) A brief description of the Client VPN endpoint."
  type        = string
}

variable "dns_servers" {
  description = "(Optional) Information about the DNS servers to be used for DNS resolution. A Client VPN endpoint can have up to two DNS servers. If no DNS server is specified, the DNS address of the connecting device is used."
  type        = list(string)
  default     = []
}

variable "security_group_ids" {
  description = "(Optional) The IDs of one or more security groups to apply to the target network. You must also specify the ID of the VPC that contains the security groups."
  type        = list(string)
  default     = []
}

variable "self_service_portal" {
  description = "(Optional) Specify whether to enable the self-service portal for the Client VPN endpoint. Values can be enabled or disabled. Default value is disabled."
  type        = string
  default     = "disabled"
}

variable "server_certificate_arn" {
  description = "(Required) The ARN of the ACM server certificate."
  type        = string
}

variable "session_timeout_hours" {
  description = " (Optional) The maximum session duration is a trigger by which end-users are required to re-authenticate prior to establishing a VPN session. Default value is 24 - Valid values: 8 | 10 | 12 | 24"
  type        = number
  default     = 24
}

variable "split_tunnel" {
  description = " (Optional) Indicates whether split-tunnel is enabled on VPN endpoint. Default value is false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

variable "transport_protocol" {
  description = "(Optional) The transport protocol to be used by the VPN session. Default value is udp."
  type        = string
  default     = "udp"
}

variable "vpc_id" {
  description = "(Optional) The ID of the VPC to associate with the Client VPN endpoint. If no security group IDs are specified in the request, the default security group for the VPC is applied."
  type        = string
  default     = null
}

variable "vpn_port" {
  description = "(Optional) The port number for the Client VPN endpoint. Valid values are 443 and 1194. Default value is 443."
  type        = number
  default     = 443
}

variable "authentication_options" {
  description = "(Required) Information about the authentication method to be used to authenticate clients."
  type        = map(string)
}

variable "client_connect_options" {
  description = "(Optional) The options for managing connection authorization for new client connections."
  type        = map(string)
  default     = {}
}

variable "client_login_banner_options" {
  description = "(Optional) Options for enabling a customizable text banner that will be displayed on AWS provided clients when a VPN session is established."
  type        = map(string)
  default     = {}
}

variable "connection_log_options" {
  description = "(Required) Information about the client connection logging options."
  type        = map(string)
}

variable "security_group_ingress" {
  description = "Specify the ingress rule for the security group"
  type        = any
  default     = {}
}
