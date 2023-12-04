variable "supporting_resources_name" {
  description = "Name of supporting resource VPC"
  type        = string
  default     = "terraform-aws-vpn-client"
}

variable "name" {
  description = "Name must be 255 characters or less in length."
  type        = string
  default     = "complete-example-client-vpn"
}

variable "client_cidr_block" {
  description = "(Required) The IPv4 address range, in CIDR notation, from which to assign client IP addresses. The address range cannot overlap with the local CIDR of the VPC in which the associated subnet is located, or the routes that you add manually. The address range cannot be changed after the Client VPN endpoint has been created. The CIDR block should be /22 or greater."
  type        = string
  default     = "192.168.0.0/16"
}

variable "split_tunnel" {
  description = " (Optional) Indicates whether split-tunnel is enabled on VPN endpoint. Default value is false."
  type        = bool
  default     = true
}

variable "authentication_options" {
  description = "(Required) Information about the authentication method to be used to authenticate clients."
  type        = map(string)
  default = {
    type = "certificate-authentication"
  }
}

variable "connection_log_options" {
  description = "(Required) Information about the client connection logging options."
  type        = map(string)
  default = {
    enabled = true
  }
}

variable "create_kms_key" {
  description = "Choose whether to create kms key for logs encryption"
  type        = bool
  default     = true
}

variable "security_group_ingress" {
  description = "Specify the ingress rule for the security group"
  type        = any
  default = [
    {
      description = "inbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "ca_subject" {
  description = "The subject for which ca certificate is being requested. The acceptable arguments are all optional "
  type        = any
  default = {
    common_name = "ca.complete.local"
  }
}

variable "server_subject" {
  description = "The subject for which server certificate is being requested. The acceptable arguments are all optional "
  type        = any
  default = {
    common_name = "server.complete.local"
  }
}

variable "client_subject" {
  description = "The subject for which client certificate is being requested. The acceptable arguments are all optional "
  type        = any
  default = {
    common_name = "client.complete.local"
  }
}

variable "create_client_certificate" {
  description = "Whether to create client certificate"
  type        = bool
  default     = true
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default = {
    Environment        = "example"
    "user::CostCenter" = "terraform-registry"
    Department         = "DevOps"
    Project            = "Examples"
    Owner              = "Boldlink"
    LayerName          = "Example"
    LayerId            = "Example"
  }
}

variable "session_timeout_hours" {
  description = " (Optional) The maximum session duration is a trigger by which end-users are required to re-authenticate prior to establishing a VPN session. Default value is 24 - Valid values: 8 | 10 | 12 | 24"
  type        = number
  default     = 12
}

variable "vpn_port" {
  description = "(Optional) The port number for the Client VPN endpoint. Valid values are 443 and 1194. Default value is 443."
  type        = number
  default     = 443
}

variable "dns_servers" {
  description = "(Optional) Information about the DNS servers to be used for DNS resolution. A Client VPN endpoint can have up to two DNS servers. If no DNS server is specified, the DNS address of the connecting device is used."
  type        = list(string)
  default     = ["8.8.8.8", "8.8.4.4"]
}

variable "client_login_banner_options" {
  description = "(Optional) Options for enabling a customizable text banner that will be displayed on AWS provided clients when a VPN session is established."
  type        = map(string)
  default = {
    banner_text = "Example client VPN login banner text. Your connection was successful!"
    enabled     = true
  }
}
