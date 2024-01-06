variable "use_default_creds" {
  type    = bool
  default = false
}

variable "default_region" {
  type    = string
  default = "us-east-1"
}

# ddb
variable "dynamodb_table_name" {
  type    = string
  default = "bsm-raw-data"
}

# iot
variable "iot_thing_type" {
  type    = string
  default = "BesideMonitor"
}

variable "iot_thing_group" {
  type    = string
  default = "Wing01"
}

variable "iot_thing" {
  type    = string
  default = "BSM_01"
}

# iam
variable "ddb_role_name" {
  type    = string
  default = "ddbrole"
}
