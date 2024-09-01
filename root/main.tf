resource "google_storage_bucket" "reunion" {
  name          = "gcp-ko-ru-blobs"
  location      = "us-east4"
  force_destroy = true

  uniform_bucket_level_access = true

  public_access_prevention = "enforced"
  versioning {
    enabled = true
  }

  timeouts {
    read = "4m"
  }

}

resource "google_storage_bucket_object" "tree" {
  name                = "family_tree.png"
  source              = "../assets/img/FamilyTree.png"
  bucket              = google_storage_bucket.reunion.name
}

resource "google_service_account" "signing_service_acct" {
  account_id   = "reunion-download-acct"
  display_name = "Signed URL Account for tree download"
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.reunion.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.signing_service_acct.email}"
}

resource "null_resource" "generate_signed_url" {
  depends_on = [ google_service_account.signing_service_acct, google_storage_bucket_object.tree ]
  provisioner "local-exec" {
    command = "/bin/bash ../assets/scripts/signedUrl.sh"
  }
  
}