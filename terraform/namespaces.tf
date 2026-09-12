locals {
  namespaces = {
    argocd         = "gitops"
    argo-rollouts  = "progressive-delivery"
    kyverno        = "policy-enforcement"
    sealed-secrets = "encrypted-secrets"
    sa-p8          = "mediconnect-production"
  }
}

resource "kubernetes_namespace_v1" "managed" {
  for_each = local.namespaces

  metadata {
    name = each.key

    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "mediconnect.io/purpose"       = each.value
    }
  }
}