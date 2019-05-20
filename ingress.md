### `HTTPs Ingress`

[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress)
manages external access to services in kubernetes cluster.

#### Install nginx controller (1.6.8)

Make sure you update (`helm repo update`) and check the name of
the registered default helm repository (`helm repo list`).  
![](images/userinput.png)

> `$_> helm install stable/nginx-ingress \`  
> `--name nginx-ingress --version 1.6.8`

#### Install cert manager (v0.8.0)

```shell
# Install the CustomResourceDefinition resources separately
$_> kubectl apply \
    -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.8/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
$_> kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
$_> kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
$_> helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
$_> helm repo update

# Install the cert-manager Helm chart
$_> helm install jetstack/cert-manager \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.8.0

```

#### Issuer and Certificate

Each developer gets their own subdomain at [dictybase.dev](https://www.dictybase.dev).
This template will serve as a guide used for all developers. Here,
`eric` will be used as an example.

Save the following yaml say as `issuer.yml` that
references the above secret(ca-key-pair).

```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: dictybase-eric-dev
  namespace: dictybase
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: YOUR_EMAIL_HERE...
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: dictybase-eric-dev
    # Enable the HTTP-01 challenge provider
    http01: {}
```

Create an `Issuer` resource.  
![](images/userinput.png)

> `$_> kubectl create -f issuer.yml`

Save the following yaml say as `certificate.yaml`.

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

Create a `Certificate` resource.

> `$_> kubectl create -f certificate.yaml`

To update an existing `Certificate` resource.

> `$_> kubectl apply -f certificate.yaml`
