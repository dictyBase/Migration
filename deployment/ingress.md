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
of deployments should be following at least for the first time.

## Install cert manager (v0.8.0)
> Chart version [https://hub.helm.sh/charts/jetstack/cert-manager/v0.8.0](0.8.0)

Install the CustomResourceDefinition resources separately   

![](userinput.png)
> `$_> kubectl apply \`   
>  `  -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml`

> `$_> kubectl create namespace cert-manager`

> `$_> kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true`

> `$_> helm repo add jetstack https://charts.jetstack.io`

> `$_> helm repo update`

> `$_> helm install jetstack/cert-manager --name cert-manager \`   
>                    `--namespace cert-manager --version v0.8.0`

## Issuer and Certificate for https access
Each developer gets their own subdomain at
[dictybase.dev](https://dictybase.dev). This template will serve as a guide
used for all developers. Here, `eric` will be used as an example.
Two resources have to be created `issuer` and `certificate`.
****

__Issuer__
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  # change the developer name accordingly
  name: dictybase-eric-dev # chang
  namespace: dictybase
spec:
  acme:
    # The ACME server URL, for the first setup it’s preferable to use their staging server
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: YOUR_EMAIL_HERE...
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: dictybase-eric-dev
    # Enable the HTTP-01 challenge provider
    http01: {}
```

![](userinput.png)
> `$_> kubectl apply -f issuer.yml`

****
__Certificate__
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: dicty-eric-dev
  namespace: dictybase
spec:
  secretName: dicty-eric-dev-tls
  issuerRef:
    kind: Issuer
    name: dictybase-eric-dev
  dnsNames:
    - eric.dictybase.dev
    - ericapi.dictybase.dev
    - ericauth.dictybase.dev
    - ericfunc.dictybase.dev
    - ericgraphql.dictybase.dev
    - ericstorage.dictybase.dev
    - erictoken.dictybase.dev
  acme:
    config:
      - http01:
          ingressClass: nginx
        domains:
          - eric.dictybase.dev
          - ericapi.dictybase.dev
          - ericauth.dictybase.dev
          - ericfunc.dictybase.dev
          - ericgraphql.dictybase.dev
          - ericstorage.dictybase.dev
          - erictoken.dictybase.dev
```

![](userinput.png)
> `$_> kubectl apply -f certificate.yaml`
