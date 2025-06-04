output "vm_external_ips" {
  description = "External IP addresses of the created VMs"
  value = {
    for vm in yandex_compute_instance.vm:
    vm.name => vm.network_interface.0.nat_ip_address
  }
}

output "vm_internal_ips" {
  description = "Internal IP addresses of the created VMs"
  value = {
    for vm in yandex_compute_instance.vm:
    vm.name => vm.network_interface.0.ip_address
  }
}

output "proxy_vm_ip" {
  description = "External IP of the first VM (proxy)"
  value       = yandex_compute_instance.vm[0].network_interface.0.nat_ip_address
}

output "backend_vm_ips" {
  description = "External IPs of backend VMs"
  value = [
    for vm in slice(yandex_compute_instance.vm, 1, length(yandex_compute_instance.vm)):
    vm.network_interface.0.nat_ip_address
  ]
}
