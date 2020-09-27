#-------------------------ssh_firewall
module "firewall-ssh" {
    source = "git@github.com:OlehKuryshko/modules.git//gcp-firewall"
    source_tags = "ssh"
    ports = "22"
    network = "${google_compute_network.my_vpc_network.name}"
  }
#-------------------------jenkins_firewall
module "firewall-jenkins" {
    source = "git@github.com:OlehKuryshko/modules.git//gcp-firewall"
    source_tags = "jenkins"
    ports = "8080"
    network = "${google_compute_network.my_vpc_network.name}"
  }
#-------------------------sonar_firewall
module "firewall-sonar" {
    source = "git@github.com:OlehKuryshko/modules.git//gcp-firewall"
    source_tags = "sonar"
    ports = "9000"
    network = "${google_compute_network.my_vpc_network.name}"
  }