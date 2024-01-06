resource "aws_iot_policy" "pubsub" {
  name = "PubSubToAnyTopic"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iot:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iot_certificate" "cert" {
  active = true
}

resource "local_file" "pubkey" {
  content  = aws_iot_certificate.cert.public_key
  filename = "public.key"
}

resource "local_file" "pvtkey" {
  content  = aws_iot_certificate.cert.private_key
  filename = "private.key"
}

resource "local_file" "cert" {
  content  = aws_iot_certificate.cert.certificate_pem
  filename = "pem.crt"
}

resource "aws_iot_policy_attachment" "att" {
  policy = aws_iot_policy.pubsub.name
  target = aws_iot_certificate.cert.arn
}

resource "aws_iot_thing_type" "bsm" {
  name = var.iot_thing_type
}

resource "aws_iot_thing_group" "wing" {
  name = var.iot_thing_group
}

resource "aws_iot_thing" "bsm1" {
  name            = var.iot_thing
  thing_type_name = aws_iot_thing_type.bsm.name
}

resource "aws_iot_thing_principal_attachment" "att" {
  principal = aws_iot_certificate.cert.arn
  thing     = aws_iot_thing.bsm1.name
}

data "aws_iot_endpoint" "endpoint" {
  endpoint_type = "iot:Data-ATS"
}

resource "local_file" "endpoint" {
  content  = data.aws_iot_endpoint.endpoint.endpoint_address
  filename = "endpoint.txt"
}

output "iot_endpoint" {
  value = data.aws_iot_endpoint.endpoint.endpoint_address
}

resource "aws_iot_topic_rule" "rule" {
  name        = "ddb"
  enabled     = true
  sql         = "SELECT * FROM 'iot/bsm'"
  sql_version = "2016-03-23"

  dynamodbv2 {
    put_item {
      table_name = aws_dynamodb_table.bsm.id
    }
    role_arn = aws_iam_role.iot_ddb_role.arn
  }
}
