# ---------------------------------------------------------
# 1. VPC
# ---------------------------------------------------------
resource "google_compute_network" "spark_vpc" {
  name                    = "spark-vpc-network"
  auto_create_subnetworks = false
}

# ---------------------------------------------------------
# 2. SUBNET
# ---------------------------------------------------------
resource "google_compute_subnetwork" "spark_subnet" {
  name          = "spark-subnet-sg"
  ip_cidr_range = "10.0.1.0/24"
  region        = "asia-southeast1"
  network       = google_compute_network.spark_vpc.id
}

# ---------------------------------------------------------
# 3. FIREWALL
# ---------------------------------------------------------

# Access right 1: allow internal VM communication
resource "google_compute_firewall" "allow_internal" {
  name    = "spark-allow-internal"
  network = google_compute_network.spark_vpc.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }

  # Chỉ cho phép IP trong dải subnet gọi nhau
  source_ranges = ["10.0.1.0/24"]
}

# Access right 2: allow SSH and Spark Web UI from external world
resource "google_compute_firewall" "allow_external" {
  name    = "spark-allow-ssh-web"
  network = google_compute_network.spark_vpc.name

  allow {
    protocol = "tcp"
    ports    = [
      "22",   # ssh access to VM
      "8080", # Spark Master Web UI
      "8081", # Spark Worker Web UI
      "4040", # Spark Driver UI
      "7077",  # Spark Master RPC
      "50070"
    ]
  }
  source_ranges = ["0.0.0.0/0"]
}