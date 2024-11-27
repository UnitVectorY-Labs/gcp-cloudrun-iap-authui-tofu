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
<!-- END_TF_DOCS -->
