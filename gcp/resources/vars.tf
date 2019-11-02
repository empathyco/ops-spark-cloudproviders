variable "region" {
    description = "Set region"
}
variable "projectID" {
    description = "Set project ID"
}

variable "google_storage_bucket_name_dataproc" {
    description = "Set storage bucket name for dataproc"
}

variable "google_storage_bucket_location" {
    description = "Set storage bucket location"
    default = "europe-west1"
}

variable "google_storage_bucket_storage_class" {
    description = "Set storage class"
    default = "REGIONAL"
}

variable "google_storage_bucket_name_jars" {
    description = "Set storage bucket name for jars"
}