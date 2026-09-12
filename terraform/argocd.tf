resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.9.0"
  namespace  = kubernetes_namespace_v1.managed["argocd"].metadata[0].name

  create_namespace = false
  wait             = true
  atomic           = true
  cleanup_on_fail  = true
  timeout          = 600

  set {
    name  = "createClusterRoles"
    value = "false"
  }

  set {
    name  = "dex.enabled"
    value = "false"
  }

  depends_on = [
    kubernetes_role_binding_v1.argocd_application_manager,
  ]
}