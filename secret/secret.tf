resource "kubernetes_secret" "svd-certificates" {
    metadata {
      name = "svd-certificates"
      namespace = "svd-terraform"
    }
    data = {
       "SVD-primary-server.pem" = file("${path.module}/SVD-primary-server.pem")
    }
    type = "Opaque"
  
}

resource "kubernetes_secret" "svd-primary-secret" {
    metadata {
        name = "svd-primary-secret"
        namespace = "svd-terraform"

    }   
    type = "Opaque"
    data = {
        "adminDn" : "cn=root"
        "adminPassword": "passw0rd1"
        "licenseKey": "R2VuZXJpYzotMToxOjCCAacGCSqGSIb3DQEHAqCCAZgwggGUAgEBMQ8wDQYJYIZIAWUDBAIBBQAwGwYJKoZIhvcNAQcBoA4EDEdlbmVyaWM6LTE6MaAAMYIBXTCCAVkCAQEwSDA8MQswCQYDVQQGEwJ1czEMMAoGA1UEChMDaWJtMQ0wCwYDVQQLEwRpc3ZhMRAwDgYDVQQDEwdzaWduaW5nAgh4PC0gxTSNfzANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMTAxMDA2NTgyN1owLwYJKoZIhvcNAQkEMSIEICNI9qWOUQ1SXQXNbnOMT5HDinpaosSdz13WyWX2XFLiMA0GCSqGSIb3DQEBAQUABIGARibpp/5rnoMDqO9rOSKFwx3m0bbYGgvkiJtDbHcRHTzErgvxqpYV0NLa9CpsCrzySCxiC2v5Xh4XhkalH6IABYWv+ZWRkh1aen8lshEYR1EAgs8llh3FmQ9xRGTJp1XkacRx3XI/s5dNNtWGEqoc1eX3cCXIG9WvO7Uoxc84b+I="
        "replicaAdminDn": "cn=replcred"
        "replicaAdminPassword": "passw0rd2"
    }
  
}