# GKE cluster admin
To add and manipulate kubernetes
[RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
the account that execute `kubectl` binary must have cluster
administrative permission.

* Extract the active authenticated gcloud account.
It is expected to print an email of the account.
>`$_>  gcloud config list account --format "value(core.account)"`   

* Create the kubernetes administrative access with this account

> `$_> kubectl create clusterrolebinding dictyadmin \`   
>      `--clusterrole=cluster-admin \`   
>      `--user=[email from the previous command]`


