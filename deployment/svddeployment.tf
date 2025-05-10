resource "kubernetes_deployment" "svd-deployment" {
    metadata {
      name = "isvd-server"
      labels = {
        "App" = "isvd-server"
      }
      namespace = "svd-terraform"
    }
    spec {
      selector {
        match_labels = {
          "App" = "isvd-server"
        }
      }
      template {
        metadata {
          name = "isvd-server"
          labels = {
            "App" = "isvd-server"
          }
        }
        spec {
           service_account_name = "isvdnew"
           volume {
             name = "config-volume"
             config_map {
               name = "server-config"
             }
           }
           volume {
             name = "data-volume"
             persistent_volume_claim {
               claim_name = "svd-claim-tf"
             }
           }
           container {
             name = "isvd-server"
             image = "icr.io/isvd/verify-directory-server:latest"
             port {
               container_port = 9636
             

             }
             env {
               name = "YAML_CONFIG_FILE"
               value = "/var/isvd/config/config.yaml"
             }
             volume_mount {
               name = "config-volume"
               mount_path = "/var/isvd/config"
             }
             volume_mount {
               name = "data-volume"
               mount_path = "/var/isvd/data"
             }
             liveness_probe {
               exec {
                 command = ["/sbin/health_check.sh","livenessProbe"]
                 
               }
               initial_delay_seconds = 5
               period_seconds = 10
             }
             readiness_probe {
               exec {
                 command = ["/sbin/health_check.sh"]
                 
               }
               initial_delay_seconds = 5
               period_seconds = 10
             }
             startup_probe {
               exec {
                 command = ["/sbin/health_check.sh"]
                 
               }
               initial_delay_seconds = 5
               period_seconds = 10
             }
           }
          
        }
        
      }
    }
  
}