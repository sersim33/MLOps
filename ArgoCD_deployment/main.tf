
# --- Namespace для ArgoCD ---
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }
}

# --- Helm Release ArgoCD ---
resource "helm_release" "argo" {
  name       = "argocd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  recreate_pods = true
  replace       = true

  values = [file("${path.module}/values/argocd-values.yaml")]
}

# --- Root App (App of Apps) через Kubernetes Manifest ---
# Він підхоплює усі додатки з Git (mlflow, minio, postgres, pushgateway)
resource "kubernetes_manifest" "argocd_root_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "mlops-root"
      namespace = var.argocd_namespace
    }
    spec = {
      project = "default"
      source = {
        repoURL = var.app_repo_url
        targetRevision = var.app_repo_branch
        path = "argocd/applications"
        directory = {
          recurse = true
        }
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = var.argocd_namespace
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
        syncOptions = ["CreateNamespace=true"]
      }
    }
  }

  depends_on = [helm_release.argo]
}
