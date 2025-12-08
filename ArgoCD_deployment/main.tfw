
# --- Namespace для ArgoCD ---
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

# --- Helm Release ArgoCD ---
resource "helm_release" "argo" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name  # використовуємо створений namespace

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  recreate_pods = true
  replace       = true

  values = [file("${path.module}/values/argocd-values.yaml")]
}