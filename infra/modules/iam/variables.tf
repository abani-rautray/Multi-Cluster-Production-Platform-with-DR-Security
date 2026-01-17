variable "role_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "namespace_service_accounts" {
  type = list(string)
}

variable "policy_arns" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}
