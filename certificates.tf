# ca RSA key
resource "tls_private_key" "ca" {
  count     = var.create_certificates ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_self_signed_cert" "ca" {
  count           = var.create_certificates ? 1 : 0
  private_key_pem = tls_private_key.ca[0].private_key_pem

  subject {
    common_name         = lookup(var.ca_subject, "common_name", null)
    country             = lookup(var.ca_subject, "country", null)
    locality            = lookup(var.ca_subject, "locality", null)
    organization        = lookup(var.ca_subject, "organization", null)
    organizational_unit = lookup(var.ca_subject, "organizational_unit", null)
    postal_code         = lookup(var.ca_subject, "postal_code", null)
    province            = lookup(var.ca_subject, "province", null)
    serial_number       = lookup(var.ca_subject, "serial_number", null)
    street_address      = lookup(var.ca_subject, "street_address", [])
  }

  validity_period_hours = var.validity_period_hours
  is_ca_certificate     = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
}

/*resource "aws_acm_certificate" "ca" {
  private_key      = tls_private_key.ca.private_key_pem
  certificate_body = tls_locally_signed_cert.ca.cert_pem
  tags             = local.tags
}
*/

resource "aws_secretsmanager_secret" "ca" {
  count                   = var.create_certificates ? 1 : 0
  name                    = "${var.name}-ca-certificate"
  recovery_window_in_days = var.recovery_window_in_days
  description             = "${var.name} ca certificate contents"
  kms_key_id              = var.kms_key_id == null ? join("", aws_kms_key.main.*.arn) : var.kms_key_id
  tags                    = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "ca" {
  count         = var.create_certificates ? 1 : 0
  secret_id     = aws_secretsmanager_secret.ca[0].id
  secret_string = tls_private_key.ca[0].private_key_pem
}

# server RSA key
resource "tls_private_key" "server" {
  count     = var.create_certificates ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "server" {
  count           = var.create_certificates ? 1 : 0
  private_key_pem = tls_private_key.server[0].private_key_pem

  subject {
    common_name         = lookup(var.server_subject, "common_name", null)
    country             = lookup(var.server_subject, "country", null)
    locality            = lookup(var.server_subject, "locality", null)
    organization        = lookup(var.server_subject, "organization", null)
    organizational_unit = lookup(var.server_subject, "organizational_unit", null)
    postal_code         = lookup(var.server_subject, "postal_code", null)
    province            = lookup(var.server_subject, "province", null)
    serial_number       = lookup(var.server_subject, "serial_number", null)
    street_address      = lookup(var.server_subject, "street_address", [])
  }

}

resource "tls_locally_signed_cert" "server" {
  count              = var.create_certificates ? 1 : 0
  cert_request_pem   = tls_cert_request.server[0].cert_request_pem
  ca_private_key_pem = tls_private_key.ca[0].private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca[0].cert_pem
  is_ca_certificate  = false

  validity_period_hours = var.validity_period_hours

  allowed_uses = [
    "server_auth",
    "key_encipherment",
    "digital_signature",
  ]
}

resource "aws_acm_certificate" "server" {
  count             = var.create_certificates ? 1 : 0
  private_key       = tls_private_key.server[0].private_key_pem
  certificate_body  = tls_locally_signed_cert.server[0].cert_pem
  certificate_chain = tls_self_signed_cert.ca[0].cert_pem
  tags              = local.tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret" "server" {
  count                   = var.create_certificates ? 1 : 0
  name                    = "${var.name}-server-certificate"
  recovery_window_in_days = var.recovery_window_in_days
  description             = "${var.name} server certificate contents"
  kms_key_id              = var.kms_key_id == null ? join("", aws_kms_key.main.*.arn) : var.kms_key_id
  tags                    = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "server" {
  count         = var.create_certificates ? 1 : 0
  secret_id     = aws_secretsmanager_secret.server[0].id
  secret_string = tls_private_key.server[0].private_key_pem
}

# client RSA key
resource "tls_private_key" "client" {
  count     = var.create_certificates ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = var.rsa_bits
}

resource "tls_cert_request" "client" {
  count           = var.create_certificates ? 1 : 0
  private_key_pem = tls_private_key.client[0].private_key_pem

  subject {
    common_name         = lookup(var.client_subject, "common_name", null)
    country             = lookup(var.client_subject, "country", null)
    locality            = lookup(var.client_subject, "locality", null)
    organization        = lookup(var.client_subject, "organization", null)
    organizational_unit = lookup(var.client_subject, "organizational_unit", null)
    postal_code         = lookup(var.client_subject, "postal_code", null)
    province            = lookup(var.client_subject, "province", null)
    serial_number       = lookup(var.client_subject, "serial_number", null)
    street_address      = lookup(var.client_subject, "street_address", [])
  }
}

resource "tls_locally_signed_cert" "client" {
  count              = var.create_certificates ? 1 : 0
  cert_request_pem   = tls_cert_request.client[0].cert_request_pem
  ca_private_key_pem = tls_private_key.ca[0].private_key_pem
  ca_cert_pem        = tls_self_signed_cert.ca[0].cert_pem
  is_ca_certificate  = false

  validity_period_hours = var.validity_period_hours

  allowed_uses = [
    "client_auth",
    "key_encipherment",
    "digital_signature",
  ]
}

resource "aws_acm_certificate" "client" {
  count             = var.create_certificates ? 1 : 0
  private_key       = tls_private_key.client[0].private_key_pem
  certificate_body  = tls_locally_signed_cert.client[0].cert_pem
  certificate_chain = tls_self_signed_cert.ca[0].cert_pem
  tags              = local.tags
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret" "client" {
  count                   = var.create_certificates ? 1 : 0
  name                    = "${var.name}-client-certificate"
  recovery_window_in_days = var.recovery_window_in_days
  description             = "${var.name} client certificate contents"
  kms_key_id              = var.kms_key_id == null ? join("", aws_kms_key.main.*.arn) : var.kms_key_id
  tags                    = local.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "client" {
  count         = var.create_certificates ? 1 : 0
  secret_id     = aws_secretsmanager_secret.client[0].id
  secret_string = tls_private_key.client[0].private_key_pem
}
