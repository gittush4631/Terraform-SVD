resource "kubernetes_persistent_volume_claim" "svd-claim" {
    metadata {
      name = "svd-claim-tf"
      namespace = "svd-terraform"
    }
    spec {
      access_modes = ["ReadWriteOnce"]
      resources {
        requests = {
            storage = "5Gi"
        }
      }
      storage_class_name = "standard"
    }
  
}