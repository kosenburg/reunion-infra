terraform {
  backend "gcs" {
    bucket  = "gcp-ko-state"
    prefix  = "terraform/state"
  }
}
