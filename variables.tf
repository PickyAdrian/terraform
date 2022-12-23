#Project ID
variable "project_id" {
  description = "project id"
  default= "xertica-delivery-infra-service"
}

#Region
variable "region" {
  description = "region"
  default = "us-central1"
}

#Zone
variable "zone" {
  description = "zone"
  default = "us-central1-c"
}

#Number of nodes in GKE
variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}

#CIDR range for VPC
variable "ip_cidr_range" {
  default = "10.10.0.0/18"
}

#CIDR range for GKE
variable "ip_cidr_range_gke" {
  default = "10.10.0.0/18"
}

