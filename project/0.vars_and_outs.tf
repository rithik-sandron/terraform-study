variable "region" {
  default     = "europe-west2"
  description = "region"
}

variable "zone" {
  default     = "europe-west2-a"
  description = "zone"
}

variable "project_id" {
  description = "project id"
}

variable "roles" {
  description = "List of roles to assign"
  type        = list(string)
}

output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.cluster.name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = google_container_cluster.cluster.endpoint
  description = "GKE Cluster Host"
}

output "sa_roles" {
  value       = var.roles
  description = "All roles of SA"
}

