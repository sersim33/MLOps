# EKS VPC Cluster Setup

Цей репозиторій містить конфігурації Terraform для створення Amazon EKS кластера та VPC
---
## Попередні умови

1. **AWS CLI** (налаштований з доступом до вашого облікового запису AWS)  
2. **kubectl** (для доступу до EKS кластера)  
3. **Terraform** (версія >= 1.5)  
4. **AWS IAM** для створення EKS, VPC, Launch Templates, Node Groups  

---

## Інструкції по розгортанню

### 1. Ініціалізація Terraform
terraform init
## 2. Перевірка плану
terraform plan
## 3. Створення кластера та VPC
terraform apply
- Підтвердіть виконання командою yes.
Підключення до EKS
- Після створення кластера додайте контекст до kubectl:
aws eks --region eu-central-1 update-kubeconfig --name goit-eks
- Перевірте доступ до нод:
kubectl get nodes