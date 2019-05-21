# HTTPs Ingress
[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress)
manages external access to services in kubernetes cluster. To configure ingress access we need to install
* nginx-controller
* ingress manifests for opening up services
* cert-manager for https access

## Install nginx controller 
> Chart version [https://hub.helm.sh/charts/stable/nginx-ingress/1.6.8](1.6.8)

Make sure you update (`helm repo update`) and check the name of
the registered default helm repository (`helm repo list`).  

![](userinput.png)
> `$_> helm install stable/nginx-ingress --name nginx-ingress --version 1.6.8`

## Deploy ingress manifests
These will be deployed alongside the various services. This particular sequence
of deployments should be following at least for the first time. Here are the
expected manifests to be deployed.

+ Minio storage
+ Auth backend
+ API microservices
+ Frontend applications

