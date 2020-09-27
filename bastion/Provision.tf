#--------------------Bastion Provision
resource "null_resource" "Provision" {
  depends_on = ["google_compute_instance.bastion"]
  connection {
    host = "${google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip}"
    type = "ssh"
    user = "centos"
    private_key = "${file("${var.pvt_key}")}"
    agent = "false"
  }
  provisioner "file" {
     source = "${var.pvt_key}"
     destination = "/home/centos/.ssh/id_rsa"
     }
  provisioner "remote-exec" {
    inline = ["sudo chmod 600 /home/centos/.ssh/id_rsa"]
  }
  provisioner "remote-exec" {
    inline = [ "sudo yum -y update", "sudo yum -y install ansible"]
  }
  provisioner "remote-exec" {
    inline = [ "rm -rf /tmp/ansible" ]
  }
  provisioner "file" {
    source = "ansible"
    destination = "/home/centos/ansible"
  }
  provisioner "remote-exec" {
    inline = ["sudo sed -i -e 's+#host_key_checking+host_key_checking+g' /etc/ansible/ansible.cfg"]
  }
  provisioner "remote-exec" {
    inline = ["ansible-playbook -i /home/centos/ansible/hosts.txt /home/centos/ansible/playbook.yml"]
  }
}
#---------------------------generate inventory file
resource "null_resource" "update_file_db" {
  provisioner "local-exec" {
    command = "echo [sonar] >> ${var.hosts} && echo ${google_compute_instance.sonar.name} ansible_host=${google_compute_instance.sonar.network_interface.0.network_ip} >> ${var.hosts}"
  }
    depends_on = [google_compute_instance.sonar]
}