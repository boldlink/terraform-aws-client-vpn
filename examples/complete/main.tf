module "complete_client_vpn" {
  source            = "./../../"
  name              = var.name
  client_cidr_block = var.client_cidr_block
  vpc_id            = local.vpc_id
  split_tunnel      = var.split_tunnel
  authorization_rules = [{
    target_network_cidr  = "0.0.0.0/0" #todo query supporting vpc cidr
    authorize_all_groups = true
    access_group_id      = null
    description          = "Authorize traffic to supporting VPC"
  }]
  ca_subject = {
    common_name  = "ca.local"
    organization = "boldlink"
  }
  server_subject = {
    common_name  = "server.local"
    organization = "boldlink"
  }
  client_subject = {
    common_name  = "client.local"
    organization = "boldlink"
  }
  authentication_options = var.authentication_options
  connection_log_options = var.connection_log_options
  subnet_ids             = local.subnet_ids
  create_kms_key         = var.create_kms_key
  security_group_ingress = var.security_group_ingress
  tags                   = var.tags
}
