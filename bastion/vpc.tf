#--------------------VPC
resource "google_compute_network" "my_vpc_network" {
  name = "my-vpc-network-1"
  auto_create_subnetworks = false
}
#--------------------private_subnetwork
resource "google_compute_subnetwork" "private_subnetwork" {
  name          = "private-subnetwork"
  ip_cidr_range = "${var.ip_cidr_range_private}"
  region        = "${var.region}"
  network       = "${google_compute_network.my_vpc_network.self_link}"
}
#--------------------create NAT
resource "google_compute_router" "router" {
  name    = "router"
  region  = "${google_compute_subnetwork.private_subnetwork.region}"
  network = "${google_compute_network.my_vpc_network.self_link}"
  bgp {
    asn = 64514
  }
}
resource "google_compute_address" "address" {
  name   = "nat-external-address-1"
  region = "${var.region}"
}
resource "google_compute_router_nat" "simple-nat" {
  name = "nat-1"
  router = "${google_compute_router.router.name}"
  region = "${var.region}"
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips = ["${google_compute_address.address.self_link}"]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}