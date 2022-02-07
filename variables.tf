variable "tenant_id"{
  type = string
  description = "Tenant ID for Azure B2C. If empty it will use the current context."
  default = ""
}

variable "client_id"{
  type = string
  description = "Client ID with permissions on Target Azure B2C. If empty then will use current attached ID."
  default = ""
}
variable "client_secret"{
  type = string
  description = "Client Secret for client ID."
  default = ""
  sensitive = true
}

variable "policy_trust_framework_base_content" {
  type = string
  description = "Trust Framework Base XML content"
  default = ""
}
variable "policy_trust_framework_localization_content" {
  type = string
  description = "Trust Framework Localization XML content"
  default = ""
}
variable "policy_trust_framework_extensions_content" {
  type = string
  description = "Trust Framework Extensions XML content"
  default = ""
}
variable "policy_trust_framework_extensions_passwordless_content" {
  type = string
  description = "Trust Framework Extensions Passwordless XML content"
  default = ""
}
variable "policy_sign_up_or_sign_in_content" {
  type = string
  description = "Sign Up Or Signin XML content"
  default = ""
}
variable "policy_profile_edit_content" {
  type = string
  description = "Profile Edit XML content"
  default = ""
}
variable "policy_password_reset_content" {
  type = string
  description = "Password Reset XML content"
  default = ""
}
