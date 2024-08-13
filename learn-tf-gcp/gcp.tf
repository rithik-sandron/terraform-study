
provider "google" {
  #   credentials = file(var.credentials_file)
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_project_iam_custom_role" "custom_role" {
  role_id     = "customRoleId"
  title       = "Study Role"
  description = "Study role"
  permissions = [
    "storage.buckets.get",
    "storage.objects.list",
  ]
  project = var.project
}

resource "google_service_account" "my_service_account" {
  display_name = "My Service Account"
  count        = 2
  account_id   = "my-service-account-${count.index}"
}

resource "google_project_iam_binding" "binding" {
  project = var.project
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.my_service_account[0].email}",
    "serviceAccount:${google_service_account.my_service_account[1].email}"
  ]
}









# VPC Network
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


# VM Instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  count        = 1
  tags         = ["id-${count.index}"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    /*
    The presence of the access_config block, even without any arguments, 
    gives the VM an external IP address, making it accessible over the internet. 
    */
    access_config {
    }
  }
}


data "google_compute_zones" "available" {
}
