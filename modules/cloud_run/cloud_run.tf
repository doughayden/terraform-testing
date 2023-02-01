resource "google_cloud_run_service" "test-cloud-run-0" {
  name     = "test-cloud-run-0"
  project  = var.project
  location = var.region

  template {
    spec {
      service_account_name = "136454482223-compute@developer.gserviceaccount.com"
      containers {
        image = "gcr.io/${var.project}/cloudrun/test-cloud-run-0"

        env {
          name  = "PROJECT_ID"
          value = var.project
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service" "test-cloud-run-1" {
  name     = "test-cloud-run-1"
  project  = var.project
  location = var.region

  template {
    spec {
      service_account_name = "136454482223-compute@developer.gserviceaccount.com"
      containers {
        image = "gcr.io/${var.project}/cloudrun/test-cloud-run-1"

        env {
          name  = "PROJECT_ID"
          value = var.project
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Make the test cloud run services public to allUsers
# TODO - use loops to consolidate

data "google_iam_policy" "noauth-0" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

data "google_iam_policy" "noauth-1" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth-0" {
  location    = google_cloud_run_service.test-cloud-run-0.location
  project     = google_cloud_run_service.test-cloud-run-0.project
  service     = google_cloud_run_service.test-cloud-run-0.name
  policy_data = data.google_iam_policy.noauth-0.policy_data
}

resource "google_cloud_run_service_iam_policy" "noauth-1" {
  location    = google_cloud_run_service.test-cloud-run-1.location
  project     = google_cloud_run_service.test-cloud-run-1.project
  service     = google_cloud_run_service.test-cloud-run-1.name
  policy_data = data.google_iam_policy.noauth-1.policy_data
}

# ### #
# not using the kruezwerker provider for this experiment
# ### #

# terraform {
#   required_providers {
#     docker = {
#       source  = "kreuzwerker/docker"
#       version = "3.0.1"
#     }
#   }
# }

# resource "docker_image" "test-cloud-run" {
#   name = "gcr.io/${var.project}/cloudrun/test-cloud-run:${var.image_tag}"
#   build {
#     context = "${path.cwd}/modules/cloud_run/test-cloud-run"
#   }
#   triggers = {
#     dir_sha1 = sha1(join("", [for f in fileset(path.module, "test-cloud-run/*") : filesha1("${path.module}/${f}")]))
#   }
# }

# ^^^ Ref: https://stackoverflow.com/questions/51138667/can-terraform-watch-a-directory-for-changes
# https://developer.hashicorp.com/terraform/language/functions/fileset

# resource "docker_registry_image" "test-cloud-run" {
#   name = docker_image.test-cloud-run.name
#   triggers = {
#     dir_sha1 = sha1(join("", [for f in fileset(path.module, "test-cloud-run/*") : filesha1("${path.module}/${f}")]))
#   }
# }

# provider "docker" {
#   registry_auth {
#     address     = "gcr.io"
#     config_file = pathexpand("${path.cwd}/.docker/config.json")
#   }
# }
