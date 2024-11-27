[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Concept](https://img.shields.io/badge/Status-Concept-white)](https://guide.unitvectorylabs.com/bestpractices/status/#concept)


# gcp-cloudrun-iap-authui-tofu

Deploys GCP's IaP authui to Cloud Run as an internet facing endpoint.

## Usage

```hcl
module "gcp-cloudrun-iap-authui-tofu" {
  source     = "git::https://github.com/UnitVectorY-Labs/gcp-cloudrun-iap-authui-tofu.git?ref=main"
  name       = "example"
  project_id = var.project_id
  region     = "your-gcp-region"
  display_name = "IaP AuthUI"
  icon_url     = "https://example.com/icon.png"
  logo_url     = "https://example.com/logo.png"
  tos_url      = "https://example.com/terms"
  privacy_policy_url = "https://example.com/privacy"

  iap_config = {
    "API_KEY_GOES_HERE" = {
      tenants = {
        "_" = {
          sign_in_options = [
            { provider = "github.com" }
          ]
        }
      }
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_service_iam_member.allusers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_service_iam_member) | resource |
| [google_cloud_run_v2_service.authui](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service) | resource |
| [google_project_iam_member.identitytoolkit_viewer](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cloud_run_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_member.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_member) | resource |
| [google_storage_bucket_object.config](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [random_uuid.example](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | The display name of the tenant | `string` | `"IaP AuthUI"` | no |
| <a name="input_iap_config"></a> [iap\_config](#input\_iap\_config) | Map of API keys to their respective IAP configurations. | <pre>map(object({<br/>    tenants = map(object({<br/>      sign_in_options = list(object({<br/>        provider = string<br/>      }))<br/>    }))<br/>  }))</pre> | n/a | yes |
| <a name="input_icon_url"></a> [icon\_url](#input\_icon\_url) | The URL of the icon for the tenant | `string` | `""` | no |
| <a name="input_logo_url"></a> [logo\_url](#input\_logo\_url) | The URL of the logo for the tenant | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the application (used for Cloud Run & Pub/Sub) | `string` | n/a | yes |
| <a name="input_privacy_policy_url"></a> [privacy\_policy\_url](#input\_privacy\_policy\_url) | The URL of the privacy policy for the tenant | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to deploy resources to | `string` | n/a | yes |
| <a name="input_tos_url"></a> [tos\_url](#input\_tos\_url) | The URL of the terms of service for the tenant | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
