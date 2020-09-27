#--------------------Bucket for tfstate
resource "google_storage_bucket" "tfstate-ecshool" {
  name          = "${var.bucket-name}"
  location      = "${var.region}"
  storage_class = "${var.storage-class}"
}