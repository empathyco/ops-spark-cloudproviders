resource "google_service_account" "sa" {
  account_id   = "devfest"
  display_name = "A service account for DevFest"
}


resource "google_project_iam_member" "editor" {
  project = "${var.projectID}"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.sa.email}"
}

resource "google_project_iam_member" "storage" {
  project = "${var.projectID}"
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.sa.email}"
}
