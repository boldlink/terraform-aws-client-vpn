resource "aws_ec2_client_vpn_endpoint" "main" {
  client_cidr_block      = var.client_cidr_block
  description            = var.description
  dns_servers            = var.dns_servers
  security_group_ids     = compact(concat([aws_security_group.main.id], var.security_group_ids))
  self_service_portal    = var.self_service_portal
  server_certificate_arn = var.create_certificates ? aws_acm_certificate.server[0].arn : var.server_certificate_arn
  session_timeout_hours  = var.session_timeout_hours
  split_tunnel           = var.split_tunnel
  transport_protocol     = var.transport_protocol
  vpc_id                 = var.vpc_id
  vpn_port               = var.vpn_port
  tags                   = local.tags

  authentication_options {
    type                           = lookup(var.authentication_options, "type", )
    saml_provider_arn              = lookup(var.authentication_options, "saml_provider_arn", null)
    active_directory_id            = lookup(var.authentication_options, "active_directory_id", null)
    root_certificate_chain_arn     = lookup(var.authentication_options, "type", ) == "certificate-authentication" && var.create_certificates ? aws_acm_certificate.client[0].arn : lookup(var.authentication_options, "root_certificate_chain_arn", null)
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
    cloudwatch_log_group  = local.cloudwatch_log_group
    cloudwatch_log_stream = lookup(var.connection_log_options, "cloudwatch_log_stream", null)
    enabled               = lookup(var.connection_log_options, "enabled")
  }
}

resource "aws_ec2_client_vpn_network_association" "main" {
  count                  = length(var.subnet_ids) > 0 ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  subnet_id              = var.subnet_ids[count.index]
}

resource "aws_ec2_client_vpn_route" "main" {
  count                  = length(var.vpn_routes) > 0 ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  destination_cidr_block = lookup(var.vpn_routes[count.index], "destination_cidr_block")
  description            = lookup(var.vpn_routes[count.index], "description", "${var.description} route")
  target_vpc_subnet_id   = lookup(var.vpn_routes[count.index], "target_vpc_subnet_id")
  depends_on             = [aws_ec2_client_vpn_network_association.main]
}

resource "aws_ec2_client_vpn_authorization_rule" "main" {
  count                  = length(var.authorization_rules) > 0 ? 1 : 0
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.main.id
  target_network_cidr    = lookup(var.authorization_rules[count.index], "target_network_cidr")
  access_group_id        = lookup(var.authorization_rules[count.index], "access_group_id", null)
  authorize_all_groups   = lookup(var.authorization_rules[count.index], "authorize_all_groups", true)
  description            = lookup(var.authorization_rules[count.index], "description", "${var.description} authorization rule")
}

resource "aws_security_group" "main" {
  name        = "${var.name}-security-group"
  description = "Control traffic to the VPN client"
  vpc_id      = var.vpc_id
  tags        = local.tags

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


resource "aws_kms_key" "main" {
  count                   = var.create_kms_key ? 1 : 0
  description             = "client VPN KMS key"
  enable_key_rotation     = var.enable_key_rotation
  policy                  = local.policy
  deletion_window_in_days = var.deletion_window_in_days
  tags                    = local.tags
}

resource "aws_kms_alias" "main" {
  count         = var.create_kms_key ? 1 : 0
  name          = "alias/${var.name}-key"
  target_key_id = aws_kms_key.main[0].key_id
}

resource "aws_cloudwatch_log_group" "main" {
  count             = lookup(var.connection_log_options, "enabled") ? 1 : 0
  name              = local.cloudwatch_log_group
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_id == null ? join("", aws_kms_key.main.*.arn) : var.kms_key_id
  tags              = local.tags
}
