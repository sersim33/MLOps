
## 1. Як запустити Terraform

Ініціалізація Terraform:
```sh
terraform init
```
Перевірка плану:
```sh
terraform plan
```
Застосування змін:
```sh
terraform apply
```
Підтвердьте `yes`.

---

## 2. Як перевірити, що ArgoCD працює

Перевіряємо namespace:

```sh
kubectl get ns
```
 - В нашому випадку:
NAME              STATUS   AGE
default           Active   4h16m
infra-tools       Active   3h12m
kube-node-lease   Active   4h16m
kube-public       Active   4h16m
kube-system       Active   4h16m

Перевіряємо поди ArgoCD:
```sh
kubectl get pods -n infra-tools
```
- HP@MacBook-Air-SS lesson-7 % kubectl get pods -n infra-tools
NAME                                                READY   STATUS    RESTARTS   AGE
argocd-application-controller-0                     0/1     Pending   0          89m
argocd-applicationset-controller-8599d5c69b-r7q2l   1/1     Running   0          89m
argocd-dex-server-76f4b6f6bf-nzgql                  0/1     Pending   0          89m
argocd-notifications-controller-5447784cc4-t6pzd    1/1     Running   0          89m
argocd-redis-6685489bf6-jc86g                       0/1     Pending   0          89m
argocd-repo-server-c95868cf6-pk6ql                  1/1     Running   0          89m
argocd-server-84b8dff9bf-hjhqs                      1/1     Running   0 

## ВАЖЛИВИЙ МОМЕНТ ЩОДО pod-ів: ЇХ КІЛЬКІСТЬ ОБМЕЖЕНА ЧЕРЕЗ НЕСТАЧУ РЕСУРСІВ КЛАСТЕРА - Збільшити кількість node-ів у кластері або змінити Instance type не можливо через AWS Free Tier. Інші варіанти не принесли бажаного результату.
---

## 3. Як відкрити UI ArgoCD

### Отримати пароль адміністратора

```sh
kubectl -n infra-tools get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
```

### Port-forward до UI

```sh
kubectl port-forward svc/argocd-server -n infra-tools 8080:443
```

Після цього зайти у браузер:

👉 [https://localhost:8080](https://localhost:8080)

(Потрібно погодитися на небезпечне підключення.)

### Логін:

* **Username:** admin
* **Password:** що отримали вище

![alt text](<Screenshot 2025-11-29 at 03.14.36.png>)

## 4. Як перевірити, що деплой виконано

Список ArgoCD Applications:

```sh
kubectl get applications -n infra-tools
```

Опис Application:

```sh
kubectl describe application ingress-nginx -n infra-tools
```

Перевірити поди, що створені Helm-чартом:

```sh
kubectl get pods -n application
```

Перевірити ресурси:

```sh
kubectl get all -n application
```

---

## 5. Посилання на репозиторій з application.yaml

```
https://github.com/sersim33/goit-argo.git
