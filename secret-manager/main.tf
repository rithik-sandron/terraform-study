terraform {
  required_providers {
    google = {
      # rxegistry.terraform.io/hashicorp/google
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}


resource "google_secret_manager_secret" "my_secret" {
  secret_id = "my-secret"
  
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "my_secret_version" {
  secret = google_secret_manager_secret.my_secret.id
  secret_data = "my-secret-value"
}

resource "google_service_account" "kubernetes_sa" {
  account_id   = "kubernetes-sa"
  display_name = "Kubernetes Service Account"
}

resource "google_project_iam_binding" "secret_accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.kubernetes_sa.email}"
  ]
}