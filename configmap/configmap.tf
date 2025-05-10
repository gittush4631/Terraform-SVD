resource "kubernetes_config_map" "server-config" {
    metadata {
      name = "server-config"
      namespace = "svd-terraform"
    }
    data = {
      "config.yaml" = file("${path.module}/config.yaml")
    }
  
}