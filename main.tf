resource "aws_ec2_client_vpn_endpoint" "main" {
  client_cidr_block      = var.client_cidr_block
  description            = var.description
  dns_servers            = var.dns_servers
  security_group_ids     = compact(concat([aws_security_group.main.id], var.security_group_ids))
  self_service_portal    = var.self_service_portal
  server_certificate_arn = var.server_certificate_arn
  session_timeout_hours  = var.session_timeout_hours
  split_tunnel           = var.split_tunnel
  transport_protocol     = var.transport_protocol
  vpc_id                 = var.vpc_id
  vpn_port               = var.vpn_port
  tags                   = merge({ Name = var.name }, var.tags)

  authentication_options {
    type                           = lookup(var.authentication_options, "type", )
    saml_provider_arn              = lookup(var.authentication_options, "saml_provider_arn", null)
    active_directory_id            = lookup(var.authentication_options, "active_directory_id", null)
    root_certificate_chain_arn     = lookup(var.authentication_options, "root_certificate_chain_arn", null)
    self_service_saml_provider_arn = lookup(var.authentication_options, "self_service_saml_provider_arn", null)
  }

  client_connect_options {
    enabled             = lookup(var.client_connect_options, "enabled", false)
    lambda_function_arn = lookup(var.client_connect_options, "lambda_function_arn", null)
  }

  client_login_banner_options {
    banner_text = lookup(var.client_login_banner_options, "banner_text", null)
    enabled     = lookup(var.client_login_banner_options, "enabled", false)
  }

  connection_log_options {
    cloudwatch_log_group  = lookup(var.connection_log_options, "cloudwatch_log_group", null)
    cloudwatch_log_stream = lookup(var.connection_log_options, "cloudwatch_log_stream", null)
    enabled               = lookup(var.connection_log_options, "enabled")
  }
}

resource "aws_security_group" "main" {
  name        = "${var.name}-security-group"
  description = "Control traffic to the VPN client"
  vpc_id      = var.vpc_id
  tags        = merge({ Name = var.name }, var.tags)

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      description      = "Rule to allow inbound traffic"
      from_port        = try(ingress.value.from_port, null)
      to_port          = try(ingress.value.to_port, null)
      protocol         = try(ingress.value.protocol, null)
      cidr_blocks      = try(ingress.value.cidr_blocks, [])
      ipv6_cidr_blocks = try(ingress.value.ipv6_cidr_blocks, [])
    }
  }

  egress {
    description      = "Rule to allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
