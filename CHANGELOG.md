# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
- module example that uses external certificate for authentication(when `var.create_certificates` == false)
- module example that uses Federated Authentication via SAML 2.0
- fix: CKV_TF_1 in vpc
- Add documentation of how to use the examples

## [1.0.0] - 2023-08-02
### Description
- feat: aws ec2 client vpn endpoint, network association, vpn routes and authorization rules
- feat: Cloudwatch log group for client vpn
- feat: optional customer master key for logs and secrets encryption
- feat: server and client certificates that are stored in acm
- feat: secrets created in secrets manager that contain certificate authority, server and client key contents
- feat: VPC as a supporting stack for the module

[Unreleased]: https://github.com/boldlink/terraform-aws-client-vpn/compare/1.0.0...HEAD

[1.0.0]: https://github.com/boldlink/terraform-aws-client-vpn/releases/tag/1.0.0
