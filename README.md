# Azure B2C Custom Flow Polices creation/update

This module will create and/or update Custom Polices within the Azure B2C.

This is using the Microsoft documentation on setting up.
https://docs.microsoft.com/en-us/azure/active-directory-b2c/deploy-custom-policies-devops

## Example

Below is the minimal example setup

```terraform
module "automation_runbook_client_secret_rotation" {
  source      = "git::https://github.com/hmcts/cnp-module-b2c-custom-flow?ref=master"

  policy_trust_framework_base_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"
  policy_trust_framework_localization_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"
  policy_trust_framework_extensions_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"
  policy_trust_framework_extensions_passwordless_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"
  policy_sign_up_or_sign_in_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"
  policy_profile_edit_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"
  policy_password_reset_content = "<TrustFrameworkPolicy></TrustFrameworkPolicy>"

}
```

### Optional
If the target Tenant is not accessible via the Managed Identity, then you can provide Service Principal credentials to authenticate and validate against that tenant.

Additional Variables are
```terraform

  tenant_id     = "8efd196a-f993-410c-a8f0-5f0c9296b3a0"
  client_id     = "fa63789d-f097-4b6d-812b-397e7c21d655"
  client_secret = "ROkB:nk8ML+D}E/"

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.policy_password_reset](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.policy_profile_edit](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.policy_sign_up_or_sign_in](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.policy_trust_framework_base](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.policy_trust_framework_extensions](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.policy_trust_framework_extensions_passwordless](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.policy_trust_framework_localization](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | Client ID with permissions on Target Azure B2C. If empty then will use current attached ID. | `string` | `""` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | Client Secret for client ID. | `string` | `""` | no |
| <a name="input_policy_password_reset_content"></a> [policy\_password\_reset\_content](#input\_policy\_password\_reset\_content) | Password Reset XML content | `string` | `""` | no |
| <a name="input_policy_profile_edit_content"></a> [policy\_profile\_edit\_content](#input\_policy\_profile\_edit\_content) | Profile Edit XML content | `string` | `""` | no |
| <a name="input_policy_sign_up_or_sign_in_content"></a> [policy\_sign\_up\_or\_sign\_in\_content](#input\_policy\_sign\_up\_or\_sign\_in\_content) | Sign Up Or Signin XMLcontent | `string` | `""` | no |
| <a name="input_policy_trust_framework_base_content"></a> [policy\_trust\_framework\_base\_content](#input\_policy\_trust\_framework\_base\_content) | Trust Framework Base XML content | `string` | `""` | no |
| <a name="input_policy_trust_framework_extensions_content"></a> [policy\_trust\_framework\_extensions\_content](#input\_policy\_trust\_framework\_extensions\_content) | Trust Framework Extensions XML content | `string` | `""` | no |
| <a name="input_policy_trust_framework_extensions_passwordless_content"></a> [policy\_trust\_framework\_extensions\_passwordless\_content](#input\_policy\_trust\_framework\_extensions\_passwordless\_content) | Trust Framework Extensions Passwordless XML content | `string` | `""` | no |
| <a name="input_policy_trust_framework_localization_content"></a> [policy\_trust\_framework\_localization\_content](#input\_policy\_trust\_framework\_localization\_content) | Trust Framework Localization XML content | `string` | `""` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenant ID for Azure B2C. If empty it will use the current context. | `string` | `""` | no |

## Outputs

No outputs.