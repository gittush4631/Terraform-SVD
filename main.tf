terraform {
  required_providers {
    kubernetes={
        source = "hashicorp/kubernetes"
    }
  }
}
variable "host" { }
variable "client_certificate" {}
variable "client_key" {}
variable "cluster_ca_certificate" {}

provider "kubernetes" {
    host= var.host
    client_certificate = base64decode(var.client_certificate)
    client_key = base64decode(var.client_key)
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
  
}
/*resource "kubernetes_namespace" "svd-terraform" {
   metadata {
      name = "svd-terraform"
   }
}*/
module "role" {
  source = "./role"
  #depends_on = [ kubernetes_namespace.svd-terraform ]
}

module "secret" {
    source = "./secret"
    
}
module "pvc" {
    source = "./pvc"
  
}
module "configmap" {
    source = "./configmap"
    depends_on = [ module.secret]
}
module "deployment" {
    source = "./deployment"
    depends_on = [ module.pvc ]
}
module "service" {
    source = "./service"
    depends_on = [ module.deployment ]
}




