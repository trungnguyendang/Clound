resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tpl", {
    # Get IP Public of Master VM
    master_ip  = google_compute_instance.spark_master.network_interface.0.access_config.0.nat_ip
    # Get  List of Workers VM IP Public
    worker_ips = google_compute_instance.spark_worker[*].network_interface.0.access_config.0.nat_ip
  })
  # path to file inventory.ini in ansible folder
  filename = "../ansible/inventory.ini"
}