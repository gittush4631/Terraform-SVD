resource "kubernetes_service" "isvd-server" {
    metadata {
      name = "isvd-server"
      namespace = "svd-terraform"

    }
    spec {
      port {
        port = 9636
        name = "isvd-server"
        protocol = "TCP"

      }
      port {
        port = 9389
        name = "isvd-server-nonssl"
        protocol = "TCP"
        target_port = 9389
      }
      selector = {
        "App": "isvd-server"
      }
      type = "ClusterIP"
    }
    
    
  
}