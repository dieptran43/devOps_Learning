terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  //Duong dan file json
  ///Volumes/Data/DevOps_T_Vinh/Week_04/TF
  credentials = file("/Volumes/Data/DevOps_T_Vinh/Week_04/TF/formal-airway-299803-d306a7f54489.json")

  project = "formal-airway-299803"
  region  = "asia-southeast1"
  zone    = "asia-southeast1-b"
}

resource "google_compute_instance" "default" {
  name         = "terraform-gcp-mock"
  machine_type = "n1-standard-2"
  zone         = "asia-southeast1-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  # // Local SSD disk
  # scratch_disk {
  #   interface = "SCSI"
  # }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}



