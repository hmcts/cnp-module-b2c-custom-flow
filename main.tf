data "azurerm_client_config" "current" {}
locals {
  tenant_id       = var.tenant_id != "" ? var.tenant_id : data.azurerm_client_config.current.tenant_id
  client_id       = var.client_id != "" ? var.client_id : data.azurerm_client_config.current.object_id
  b2c_policy_path = "${path.module}/B2CAssets"
  script_name     = "b2c_custom_policy.ps1"
}

resource "local_file" "policy_trust_framework_base" {
  content  = var.policy_trust_framework_base_content
  filename = "${local.b2c_policy_path}/TrustFrameworkBase.xml"
}
resource "local_file" "policy_trust_framework_localization" {
  content  = var.policy_trust_framework_localization_content
  filename = "${local.b2c_policy_path}/TrustFrameworkLocalization.xml"
}
resource "local_file" "policy_trust_framework_extensions" {
  content  = var.policy_trust_framework_extensions_content
  filename = "${local.b2c_policy_path}/TrustFrameworkExtensions.xml"
}
resource "local_file" "policy_trust_framework_extensions_passwordless" {
  content  = var.policy_trust_framework_extensions_passwordless_content
  filename = "${local.b2c_policy_path}/TrustFrameworkExtensionsPasswordless.xml"
}
resource "local_file" "policy_sign_up_or_sign_in" {
  content  = var.policy_sign_up_or_sign_in_content
  filename = "${local.b2c_policy_path}/SignUpOrSignin.xml"
}
resource "local_file" "policy_profile_edit" {
  content  = var.policy_profile_edit_content
  filename = "${local.b2c_policy_path}/ProfileEdit.xml"
}
resource "local_file" "policy_password_reset" {
  content  = var.policy_password_reset_content
  filename = "${local.b2c_policy_path}/PasswordReset.xml"
}

resource "null_resource" "powershell" {
  provisioner "local-exec" {
    command = "PowerShell -file ${path.module}/${local.script_name} -clientId ${local.client_id} -clientSecret ${var.client_secret} -tenantId ${local.tenant_id} -folder ${path.module}/ -files \"TrustFrameworkBase.xml,TrustFrameworkLocalization.xml,TrustFrameworkExtensions.xml,TrustFrameworkExtensionsPasswordless.xml,SignUpOrSignin.xml,ProfileEdit.xml,PasswordReset.xml\""
  }
}
