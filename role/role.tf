variable "role_name" {
    type = string
    default = "view-secret"
}
resource "kubernetes_service_account" "isvdsa" {
    metadata {
      name="isvdnew"
      namespace = "svd-terraform"
    }
  
}

resource "kubernetes_role" "view-secret" {
    metadata {
      name = var.role_name
      namespace = "svd-terraform"
    }
    rule {
      api_groups = [" "]
      resources = ["secrets"]
      verbs = ["watch","get","list"]

    }  
     
  
}

resource "kubernetes_role_binding" "rolebinding" {
    metadata {
      name = "isvd-view-configmap-secret"
      namespace = "svd-terraform"
    }
    role_ref {
      api_group = "rbac.authorization.k8s.io"
      kind = "Role"
      name = var.role_name
    }
    subject {
      kind = "ServiceAccount"
      name = "isvdnew"
      namespace = "svd-terraform"
    }
    depends_on = [ kubernetes_service_account.isvdsa, kubernetes_role.view-secret ]
    
  
}