resource "helm_release" "kyverno" {
  name       = "kyverno"
  repository = "https://kyverno.github.io/kyverno/"
  chart      = "kyverno"
  version    = "3.9.1"
  namespace  = kubernetes_namespace_v1.managed["kyverno"].metadata[0].name

  create_namespace = false
  wait             = true
  atomic           = true
  cleanup_on_fail  = true
  timeout          = 600

  depends_on = [
    helm_release.argo_rollouts,
  ]
}