### PROVIDER
provider "aws" {
  project = "advancedterraform" #replace this with your project-id
  region = "ca-central-1"
}

### NETWORK
resource "aws_vpc" "terra_vpc" {
  name = "terra_vpc"
  cidr_block = "10.0.0.0/16"
}

## SUBNET
resource "aws_subnet" "terra_subnet_a" {
  vpc_id = terra_vpc.terra_vpc.id
  cidr_block = "10.0.0.0/20"
  availability_zone = "ca-central-1"

}

### COMPUTE
## NGINX PROXY
data "aws_ami" "nginx_ami" {
  
}

resource "google_compute_instance" "nginx_instance" {
  name         = "nginx-proxy"
  machine_type = "f1-micro"
  tags = ["web"]
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
    access_config {
      
    }
  }
}

## WEB1
resource "google_compute_instance" "web1" {
  name         = "web1"
  machine_type = "f1-micro"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}
## WEB2
resource "google_compute_instance" "web2" {
  name         = "web2"
  machine_type = "f1-micro"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }
}
## WEB3
resource "google_compute_instance" "web3" {
  name         = "web3"
  machine_type = "f1-micro"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }  
}

## DB
resource "google_compute_instance" "mysqldb" {
  name         = "mysqldb"
  machine_type = "f1-micro"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = google_compute_subnetwork.subnet-1.self_link
  }  
}