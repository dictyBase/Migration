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

-- need to create issuer.yaml and certificate.yaml
-- also auth-ingress
