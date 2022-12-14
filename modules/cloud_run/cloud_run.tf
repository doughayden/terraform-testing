terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      #   version = "2.23.1"
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
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "docker_image" "test-cloud-run" {
  name = "gcr.io/${var.project}/cloudrun/test-cloud-run:1.0"
  build {
    context = "${path.cwd}/modules/cloud_run/test-cloud-run"
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "test-cloud-run/") : filesha1(f)]))
  }
}

resource "docker_registry_image" "test-cloud-run" {
  name = docker_image.test-cloud-run.name
}

provider "docker" {
  registry_auth {
    address     = "gcr.io"
    config_file = pathexpand("${path.cwd}/.docker/config.json")
  }
}


# resource "docker_config" "service_config" {
#   name = "docker-test-config-${replace(timestamp(), ":", ".")}"
#   data = base64encode(
#     file("${path.cwd}/.docker/config.json"
#     )
#   )

#   lifecycle {
#     ignore_changes        = [name]
#     create_before_destroy = true
#   }
# }