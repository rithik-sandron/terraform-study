resource "google_service_account" "sa" {
  account_id   = "${var.project_id}-sa"
  display_name = "Custom Service Account"
}

resource "google_project_iam_member" "sa-roles" {
  for_each = toset(var.roles)
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.sa.email}"
}

# binding
resource "google_service_account_iam_binding" "gsa-ksa-binding" {
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.sa.name
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[default/secret-access-sa]",
  ]
}

resource "google_container_cluster" "cluster" {
  name                     = "${var.project_id}-gke"
  network                  = google_compute_network.vpc.name
  subnetwork               = google_compute_subnetwork.subnet.name
  location                 = var.zone
  initial_node_count       = 1
  workload_identity_config {
     workload_pool = "${var.project_id}.svc.id.goog"
  }
}