output "vm-id-list" {
  value = [for i in google_compute_instance.vm_instance: i.network_interface.0.network_ip ]
}