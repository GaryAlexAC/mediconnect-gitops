resource "helm_release" "argo_rollouts" {
  name       = "argo-rollouts"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-rollouts"
  version    = "2.43.1"
  namespace  = kubernetes_namespace_v1.managed["argo-rollouts"].metadata[0].name

  create_namespace = false
  wait             = true
  atomic           = true
  cleanup_on_fail  = true
  timeout          = 600

  set {
    name  = "dashboard.enabled"
    value = "false"
  }

  depends_on = [
    helm_release.argocd,
  ]
}