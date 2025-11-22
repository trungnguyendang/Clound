output "spark_master_public_ip" {
  description = "Public IP of Master VM"
  value       = google_compute_instance.spark_master.network_interface.0.access_config.0.nat_ip
}

output "spark_worker_public_ips" {
  description = "list Public IP của các máy Worker""
  value       = google_compute_instance.spark_worker[*].network_interface.0.access_config.0.nat_ip
}