resource "aws_dynamodb_table" "bsm" {
  name      = var.dynamodb_table_name
  hash_key  = "deviceid"
  range_key = "timestamp"

  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "deviceid"
    type = "S"
  }

  attribute {
    name = "timestamp"
    type = "S"
  }
}
