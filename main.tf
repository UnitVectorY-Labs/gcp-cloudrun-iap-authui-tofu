
locals {
  authui_url = replace(google_cloud_run_v2_service.authui.uri, "https://", "")
  iap_json = {
    for api_key, config in var.iap_config :
    api_key => {
      authDomain          = local.authui_url
      displayMode         = "optionFirst"
      selectTenantUiTitle = var.display_name
      tenants = {
        for tenant_id, tenant in config.tenants :
        tenant_id => {
          displayName                = var.display_name
          iconUrl                    = var.icon_url
          logoUrl                    = var.logo_url
          immediateFederatedRedirect = false
          signInFlow                 = "redirect"
          signInOptions = [
            for option in tenant.sign_in_options :
            {
              provider = option.provider
            }
          ]
          tosUrl           = var.tos_url
          privacyPolicyUrl = var.privacy_policy_url
        }
      }
      tosUrl           = var.tos_url
      privacyPolicyUrl = var.privacy_policy_url
    }
  }
}

# Service account for Cloud Run services
resource "google_service_account" "cloud_run_sa" {
  project      = var.project_id
  account_id   = "authui-${var.name}"
  display_name = "authui Cloud Run (${var.name}) service account"
}

resource "google_cloud_run_v2_service" "authui" {
  project  = var.project_id
  location = var.region
  name     = "authui-${var.name}"
  ingress  = "INGRESS_TRAFFIC_ALL"

  deletion_protection = false

  template {
    service_account = google_service_account.cloud_run_sa.email

    containers {
      image = "gcr.io/gcip-iap/authui"

      env {
        name  = "GCS_BUCKET_NAME"
        value = google_storage_bucket.bucket.name
      }
      env {
        name  = "ALLOW_ADMIN"
        value = false
      }
      env {
        name  = "DEBUG_CONSOLE"
        value = false
      }
    }
  }
}

// Allow anonymous access to the GCP Cloud Run service
resource "google_cloud_run_service_iam_member" "allusers" {
  project  = var.project_id
  location = var.region
  service  = google_cloud_run_v2_service.authui.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

// Generate a random string
resource "random_uuid" "example" {}

// Create a GCP Bucket
resource "google_storage_bucket" "bucket" {
  project       = var.project_id
  name          = "authui-${var.name}-${random_uuid.example.result}"
  location      = var.region
  force_destroy = true
}

// Grant access to the bucket to Cloud Run Service Account
resource "google_storage_bucket_iam_member" "bucket" {
  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

// Add roles/identitytoolkit.viewer
resource "google_project_iam_member" "identitytoolkit_viewer" {
  project = var.project_id
  role    = "roles/identitytoolkit.viewer"
  member  = "serviceAccount:${google_service_account.cloud_run_sa.email}"
}

// Create a GCP Object called "config.json" in the bucket with my JSON
resource "google_storage_bucket_object" "config" {
  bucket  = google_storage_bucket.bucket.name
  name    = "config.json"
  content = jsonencode(local.iap_json)
}
