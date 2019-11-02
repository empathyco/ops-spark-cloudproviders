
provider "google" {
    project = "${var.projectID}"
    region = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket         = "terraform-a4m1n"
    prefix         = "sandbox/devfest/resources"
  }
}
resource "google_storage_bucket" "dataproc" {
  name     = "${var.google_storage_bucket_name}"
  location = "${var.google_storage_bucket_location}"
}