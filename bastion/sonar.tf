#--------------------Bastion
resource "google_compute_instance" "sonar" {
  name                    = "sonar"
  machine_type            = "${var.machine_type}"
  tags                    = ["ssh", "sonar"]
    network_interface {
    subnetwork = "${google_compute_subnetwork.private_subnetwork.name}"
      access_config {}
  }
  boot_disk {
    initialize_params {
      image               = "${var.image}"
    }
  }
     metadata = {
    ssh-keys = "${var.gce_ssh_user}:${file("${var.pub_key}")} \n${var.gce_ssh_alex}:${file("${var.pub_key_alex}")} \n${var.gce_ssh_andrii}:${file("${var.pub_key_andrii}")}"
  }
}