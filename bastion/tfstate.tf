terraform {
  backend "gcs" {
    bucket  = "terraform-tfstate-eschool"
    prefix  = "terraform/bastion"
    credentials = "../../../../../key/key.json"
  }
}