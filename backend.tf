#Save state in GCP Bucket
/* resource "google_storage_bucket" "bck" {
  name        = "bck-terraform-gke"
  location    = "US"
  uniform_bucket_level_access = true
  force_destroy = true
}

terraform {
  backend "gcs" {
    bucket = "bck-terraform-gke"
    prefix = "terraform/state"
    
  }
}  */

#Para guardarlo local
terraform {
  backend "local" {
    path = "state/terraform.tfstate"
  }
}