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
  default     = "aws client vpn"
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
  default     = ""
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

variable "subnet_ids" {
  type        = list(string)
  description = "(Required) The IDs of the subnets to associate with the Client VPN endpoint."
}

variable "vpn_routes" {
  description = "Provides additional routes for AWS Client VPN endpoints."
  type = list(object({
    target_vpc_subnet_id   = string
    destination_cidr_block = string
    description            = string
  }))
  default = []
}

variable "authorization_rules" {
  description = "Provides authorization rules for AWS Client VPN endpoints."
  type = list(object({
    target_network_cidr  = string
    access_group_id      = string
    authorize_all_groups = bool
    description          = string
  }))
  default = []
}

variable "security_group_ingress" {
  description = "Specify the ingress rule for the security group"
  type        = any
  default     = {}
}

variable "create_kms_key" {
  description = "Choose whether to create kms key for logs encryption"
  type        = bool
  default     = false
}

variable "enable_key_rotation" {
  description = "(Optional) Specifies whether key rotation is enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "deletion_window_in_days" {
  description = "(Optional) The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between 7 and 30, inclusive. If you do not specify a value, it defaults to 30. If the KMS key is a multi-Region primary key with replicas, the waiting period begins when the last of its replica keys is deleted. Otherwise, the waiting period begins immediately."
  type        = number
  default     = 30
}

variable "cloudwatch_log_group_prefix" {
  description = " Creates a unique name beginning with the specified prefix."
  type        = string
  default     = "/aws/vpn-client"

}

variable "kms_key_id" {
  description = "Amazon Resource Name (ARN) of the KMS Key to use when encrypting"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0. If you select 0, the events in the log group are always retained and never expire."
  type        = number
  default     = 1827
}

variable "recovery_window_in_days" {
  description = "(Optional) Number of days that AWS Secrets Manager waits before it can delete the secret. This value can be 0 to force deletion without recovery or range from 7 to 30 days. The default value is 30."
  type        = number
  default     = 30
}

variable "create_certificates" {
  description = "Whether to create ca,server and client certificates"
  type        = bool
  default     = true
}

variable "rsa_bits" {
  description = "the size of the generated RSA key, in bits (default: 2048)."
  type        = number
  default     = 2048
}

variable "ca_subject" {
  description = "(Block List, Max: 1) The subject for which ca certificate is being requested. The acceptable arguments are all optional "
  type        = map(any)
  default     = {}
}

variable "server_subject" {
  description = "(Block List, Max: 1) The subject for which server certificate is being requested. The acceptable arguments are all optional "
  type        = map(any)
  default     = {}
}

variable "client_subject" {
  description = "(Block List, Max: 1) The subject for which client certificate is being requested. The acceptable arguments are all optional "
  type        = map(any)
  default     = {}
}



variable "validity_period_hours" {
  description = "(Number) Number of hours, after initial issuing, that the certificate will remain valid for."
  type        = number
  default     = 17520
}
