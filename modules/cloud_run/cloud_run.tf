terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.25.0"
    }
  }
}

resource "google_cloud_run_service" "test-cloud-run" {
  name     = "test-cloud-run"
  project  = var.project
  location = var.region

  template {
    spec {
      service_account_name = "136454482223-compute@developer.gserviceaccount.com"
      containers {
        image = docker_registry_image.test-cloud-run.name

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

resource "docker_image" "test-cloud-run" {
  name = "gcr.io/${var.project}/cloudrun/test-cloud-run:${var.image_tag}"
  build {
    context = "${path.cwd}/modules/cloud_run/test-cloud-run"
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "test-cloud-run/*") : filesha1("${path.module}/${f}")]))
  }
  # lifecycle {
  #   ignore_changes = [build]
  # }
}

# ^^^ Ref: https://stackoverflow.com/questions/51138667/can-terraform-watch-a-directory-for-changes
# https://developer.hashicorp.com/terraform/language/functions/fileset

resource "docker_registry_image" "test-cloud-run" {
  name = docker_image.test-cloud-run.name
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "test-cloud-run/*") : filesha1("${path.module}/${f}")]))
  }
}

provider "docker" {
  registry_auth {
    address     = "gcr.io"
    config_file = pathexpand("${path.cwd}/.docker/config.json")
  }
}

# ### #
#
# test to see if this causes any changes in tf plan
#
# ### #
