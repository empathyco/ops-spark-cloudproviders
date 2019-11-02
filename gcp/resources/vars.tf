variable "region" {
    description = "Set region"
}
variable "projectID" {
    description = "Set project ID"
}

variable "google_storage_bucket_name" {
    description = "Set storage bucket name"
}

variable "google_storage_bucket_location" {
    description = "Set storage bucket location"
}

variable "google_storage_bucket_storage_class" {
    description = "Set storage class"
    default = "REGIONAL"
}
