#-----------GCP provider---------
provider "google" {
  version     = "~> 3.19"
  credentials = "${file("${var.key}")}"
  project     = "${var.project}"
  region      = "${var.region}"
  zone        = "${var.zone}"
}
