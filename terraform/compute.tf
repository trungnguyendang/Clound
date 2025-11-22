# =============================================================================
# 1. VM MASTER
# =============================================================================
resource "google_compute_instance" "spark_master" {
  name         = "spark-master"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-b"

  # Configure boot disk with Ubuntu 22.04 LTS image
  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 20
    }
  }

  # config network
  network_interface {
    # Connect to VPC and Subnet created in file network.tf
    network    = google_compute_network.spark_vpc.name
    subnetwork = google_compute_subnetwork.spark_subnet.name
    # Set IP for Master, that worker nodes can reach to master via internal IP
    network_ip = "10.0.1.10"
    access_config {}
  }
  tags = ["spark-node"]
  metadata = {
    #replace with real ssh key
    ssh-keys = "ssh-rsa mykeyishere trungnd"
  }
}

# =============================================================================
# 2. VM WORKERS
# =============================================================================
resource "google_compute_instance" "spark_worker" {
  count        = 2
  name         = "spark-worker-${count.index + 1}"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-b"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
      size  = 20
    }
  }

  network_interface {
    network    = google_compute_network.spark_vpc.name
    subnetwork = google_compute_subnetwork.spark_subnet.name
    access_config {}
  }

  tags = ["spark-node"]

#replace with real ssh key
  metadata = {
      ssh-keys = "ssh-rsa mykeyishere trungnd"
}