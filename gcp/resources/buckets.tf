
provider "google" {
    project = "${var.projectID}"
    region = "${var.region}"
}
/*
terraform {
  backend "remote" {
    organization = "empathy"

    workspaces {
      name = "gcp-devfest"
    }
  }
}
*/

terraform {
  backend "gcs" {
    bucket         = "terraform-a4m1n"
    prefix         = "sandbox/devfest/resources"
  }
}


resource "google_storage_bucket" "dataproc" {
  name     = "${var.google_storage_bucket_name_dataproc}"
  location = "${var.google_storage_bucket_location}"
  storage_class = "${var.google_storage_bucket_storage_class}"
}

resource "google_storage_bucket" "jars" {
  name     = "${var.google_storage_bucket_name_jars}"
  location = "${var.google_storage_bucket_location}"
  storage_class = "${var.google_storage_bucket_storage_class}"
}