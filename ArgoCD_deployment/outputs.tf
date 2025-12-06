# --- Outputs ---
output "argocd_namespace" {
  description = "Namespace, де встановлено ArgoCD"
  value       = var.argocd_namespace
}

output "argocd_release_name" {
  description = "Helm release name ArgoCD"
  value       = helm_release.argo.name
}

