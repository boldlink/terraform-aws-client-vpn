module "lambda" {
  source           = "boldlink/lambda/aws"
  version          = "1.1.1"
  function_name    = "AWSClientVPN-${var.name}" #The name of the Lambda function must begin with the AWSClientVPN- prefix.
  description      = "Example client VPN authorization lambda function"
  filename         = "lambda.zip"
  handler          = "example.lambda_handler"
  runtime          = "python3.9"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  tags = var.tags
}

module "complete_client_vpn" {
  source                = "./../../"
  name                  = var.name
  client_cidr_block     = var.client_cidr_block
  vpc_id                = local.vpc_id
  split_tunnel          = var.split_tunnel
  session_timeout_hours = var.session_timeout_hours
  vpn_port              = var.vpn_port
  dns_servers           = var.dns_servers
  authorization_rules = [{
    target_network_cidr  = local.vpc_cidr
    authorize_all_groups = true
    access_group_id      = null
    description          = "Authorize traffic to supporting VPC"
  }]
  ca_subject                  = var.ca_subject
  server_subject              = var.server_subject
  create_client_certificate   = var.create_client_certificate
  client_subject              = var.client_subject
  authentication_options      = var.authentication_options
  connection_log_options      = var.connection_log_options
  subnet_ids                  = local.subnet_ids
  create_kms_key              = var.create_kms_key
  security_group_ingress      = var.security_group_ingress
  tags                        = var.tags
  client_login_banner_options = var.client_login_banner_options
  client_connect_options = {
    enabled             = true
    lambda_function_arn = module.lambda.arn
  }
}
