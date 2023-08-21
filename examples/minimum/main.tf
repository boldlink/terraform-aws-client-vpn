module "minimum_client_vpn" {
  source                 = "./../../"
  name                   = var.name
  client_cidr_block      = var.client_cidr_block
  vpc_id                 = local.vpc_id
  split_tunnel           = var.split_tunnel
  connection_log_options = var.connection_log_options
  authorization_rules = [{
    target_network_cidr  = local.vpc_cidr
    authorize_all_groups = true
    access_group_id      = null
    description          = "Authorize traffic to supporting VPC"
  }]
  ca_subject             = var.ca_subject
  server_subject         = var.server_subject
  client_subject         = var.client_subject
  authentication_options = var.authentication_options
  subnet_ids             = local.subnet_ids
  security_group_ingress = var.security_group_ingress
  tags                   = var.tags
}
