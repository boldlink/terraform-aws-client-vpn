[![License](https://img.shields.io/badge/License-Apache-blue.svg)](https://github.com/boldlink/terraform-aws-client-vpn/blob/main/LICENSE)
[![Latest Release](https://img.shields.io/github/release/boldlink/terraform-aws-client-vpn.svg)](https://github.com/boldlink/terraform-aws-client-vpn/releases/latest)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/update.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/release.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/pre-commit.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/pr-labeler.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/module-examples-tests.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/checkov.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/auto-merge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)
[![Build Status](https://github.com/boldlink/terraform-aws-client-vpn/actions/workflows/auto-badge.yaml/badge.svg)](https://github.com/boldlink/terraform-aws-client-vpn/actions)

[<img src="https://avatars.githubusercontent.com/u/25388280?s=200&v=4" width="96"/>](https://boldlink.io)

# Terraform  module example of complete and most common configuration


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.11 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.9.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.4.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete_client_vpn"></a> [complete\_client\_vpn](#module\_complete\_client\_vpn) | ./../../ | n/a |
| <a name="module_lambda"></a> [lambda](#module\_lambda) | boldlink/lambda/aws | 1.1.1 |

## Resources

| Name | Type |
|------|------|
| [archive_file.lambda_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.supporting](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authentication_options"></a> [authentication\_options](#input\_authentication\_options) | (Required) Information about the authentication method to be used to authenticate clients. | `map(string)` | <pre>{<br>  "type": "certificate-authentication"<br>}</pre> | no |
| <a name="input_ca_subject"></a> [ca\_subject](#input\_ca\_subject) | The subject for which ca certificate is being requested. The acceptable arguments are all optional | `any` | <pre>{<br>  "common_name": "ca.complete.local"<br>}</pre> | no |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | (Required) The IPv4 address range, in CIDR notation, from which to assign client IP addresses. The address range cannot overlap with the local CIDR of the VPC in which the associated subnet is located, or the routes that you add manually. The address range cannot be changed after the Client VPN endpoint has been created. The CIDR block should be /22 or greater. | `string` | `"192.168.0.0/16"` | no |
| <a name="input_client_login_banner_options"></a> [client\_login\_banner\_options](#input\_client\_login\_banner\_options) | (Optional) Options for enabling a customizable text banner that will be displayed on AWS provided clients when a VPN session is established. | `map(string)` | <pre>{<br>  "banner_text": "Example client VPN login banner text. Your connection was successful!",<br>  "enabled": true<br>}</pre> | no |
| <a name="input_client_subject"></a> [client\_subject](#input\_client\_subject) | The subject for which client certificate is being requested. The acceptable arguments are all optional | `any` | <pre>{<br>  "common_name": "client.complete.local"<br>}</pre> | no |
| <a name="input_connection_log_options"></a> [connection\_log\_options](#input\_connection\_log\_options) | (Required) Information about the client connection logging options. | `map(string)` | <pre>{<br>  "enabled": true<br>}</pre> | no |
| <a name="input_create_client_certificate"></a> [create\_client\_certificate](#input\_create\_client\_certificate) | Whether to create client certificate | `bool` | `true` | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | Choose whether to create kms key for logs encryption | `bool` | `true` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) Information about the DNS servers to be used for DNS resolution. A Client VPN endpoint can have up to two DNS servers. If no DNS server is specified, the DNS address of the connecting device is used. | `list(string)` | <pre>[<br>  "8.8.8.8",<br>  "8.8.4.4"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name must be 255 characters or less in length. | `string` | `"complete-example-client-vpn"` | no |
| <a name="input_security_group_ingress"></a> [security\_group\_ingress](#input\_security\_group\_ingress) | Specify the ingress rule for the security group | `any` | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "description": "inbound traffic",<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_server_subject"></a> [server\_subject](#input\_server\_subject) | The subject for which server certificate is being requested. The acceptable arguments are all optional | `any` | <pre>{<br>  "common_name": "server.complete.local"<br>}</pre> | no |
| <a name="input_session_timeout_hours"></a> [session\_timeout\_hours](#input\_session\_timeout\_hours) | (Optional) The maximum session duration is a trigger by which end-users are required to re-authenticate prior to establishing a VPN session. Default value is 24 - Valid values: 8 \| 10 \| 12 \| 24 | `number` | `12` | no |
| <a name="input_split_tunnel"></a> [split\_tunnel](#input\_split\_tunnel) | (Optional) Indicates whether split-tunnel is enabled on VPN endpoint. Default value is false. | `bool` | `true` | no |
| <a name="input_supporting_resources_name"></a> [supporting\_resources\_name](#input\_supporting\_resources\_name) | Name of supporting resource VPC | `string` | `"terraform-aws-vpn-client"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. If configured with a provider default\_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | <pre>{<br>  "Department": "DevOps",<br>  "Environment": "example",<br>  "LayerId": "Example",<br>  "LayerName": "Example",<br>  "Owner": "Boldlink",<br>  "Project": "Examples",<br>  "user::CostCenter": "terraform-registry"<br>}</pre> | no |
| <a name="input_vpn_port"></a> [vpn\_port](#input\_vpn\_port) | (Optional) The port number for the Client VPN endpoint. Valid values are 443 and 1194. Default value is 443. | `number` | `443` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Third party software
This repository uses third party software:
* [pre-commit](https://pre-commit.com/) - Used to help ensure code and documentation consistency
  * Install with `brew install pre-commit`
  * Manually use with `pre-commit run`
* [terraform 0.14.11](https://releases.hashicorp.com/terraform/0.14.11/) For backwards compatibility we are using version 0.14.11 for testing making this the min version tested and without issues with terraform-docs.
* [terraform-docs](https://github.com/segmentio/terraform-docs) - Used to generate the [Inputs](#Inputs) and [Outputs](#Outputs) sections
  * Install with `brew install terraform-docs`
  * Manually use via pre-commit
* [tflint](https://github.com/terraform-linters/tflint) - Used to lint the Terraform code
  * Install with `brew install tflint`
  * Manually use via pre-commit

#### BOLDLink-SIG 2023
