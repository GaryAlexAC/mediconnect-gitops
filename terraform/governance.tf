resource "kubernetes_resource_quota_v1" "sa_p8" {
  metadata {
    name      = "mediconnect-quota"
    namespace = kubernetes_namespace_v1.managed["sa-p8"].metadata[0].name
  }

  spec {
    hard = {
      "pods"                   = "30"
      "requests.cpu"           = "3"
      "requests.memory"        = "6Gi"
      "limits.cpu"             = "6"
      "limits.memory"          = "8Gi"
      "persistentvolumeclaims" = "4"
      "requests.storage"       = "20Gi"
    }
  }
}

resource "kubernetes_limit_range_v1" "sa_p8" {
  metadata {
    name      = "mediconnect-default-limits"
    namespace = kubernetes_namespace_v1.managed["sa-p8"].metadata[0].name
  }

  spec {
    limit {
      type = "Container"

      default = {
        cpu    = "500m"
        memory = "512Mi"
      }

      default_request = {
        cpu    = "100m"
        memory = "128Mi"
      }
    }
  }
}