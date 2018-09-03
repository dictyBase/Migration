* Enable billing
* Setup default project-id
* Setup default zone
* Setup service account
* Create cluster
```shell
gcloud beta container clusters create staging \
    --no-enable-basic-auth --cluster-version "1.9.7-gke.3" \
    --machine-type "custom-4-4096" --image-type COS \ 
    --disk-type pd-ssd --disk-size 50 \ 
    --service-account "dictykube-service-account@dictybase-kubernetes.iam.gserviceaccount.com" \ 
    --num-nodes 4 --enable-cloud-logging --enable-cloud-monitoring \ 
    --network default --subnetwork default \
    --addons HorizontalPodAutoscaling,HttpLoadBalancing \ 
    --no-enable-autoupgrade --enable-autorepair
```
* Add the default storage class
* RBAC stuff for helm   
```
kubectl -n kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller
```
* Initialize helm   
```helm init --service-account=tiller```

* A cluster admin role for the current executing user   
First get the email of the current user
`gcloud info | grep Account`

```
kubectl create clusterrolebinding dictyadmin \
    --clusterrole=cluster-admin \
    --user=youremail@email.org
```

* RBAC for arango-operator from the config folder or
  [here](https://raw.githubusercontent.com/arangodb/kube-arangodb/0.1.0/manifests/arango-deployment.yaml)

* The `Cluster` mode or arangodb seems to work with custom storage class and
  disk size for all the groups(dbservers etc). The `Single` mode does not work
  in `gke`. The `ActiveFailOver` mode does not allow any custom storage class
  or disk size for `dbservers` group.

* RBAC for the node-operator from the config folder or from
  [here](https://github.com/nats-io/nats-operator/blob/master/example/deployment-rbac.yaml).
  The `clusterrolebinding` should use the name `default`.
* Install nginx controller in gke.
* For deploying kubeless functions covert the service to NodePort.
* Create another certificate resource for minio storage. The existing
  certificate is no longer getting renewed for new dns names because of some
  previous errors. Hopefully, this will not be the case for production.
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: dictystorage-staging
  namespace: dictybase
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: dictybasebot@gmail.com
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: dictystorage-staging
    # Enable the HTTP-01 challenge provider
    http01: {}
```
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: dictystorage-staging-org
  namespace: dictybase
spec:
  secretName: dictystorage-staging-org-tls
  issuerRef:
    kind: Issuer
    name: dictystorage-staging
  dnsNames:
  - betastorage.dictybase.org
  acme:
    config:
    - http01:
        ingressClass: nginx
      domains:
      - betastorage.dictybase.org
```
* Use a separate ingress for minio
```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/proxy-body-size: 550M
  labels:
    app: minio
  name: minio
  namespace: dictybase
spec:
  rules:
  - host: betastorage.dictybase.org
    http:
      paths:
      - backend:
          serviceName: minio
          servicePort: 9000
  tls:
  - hosts:
    - betastorage.dictybase.org
    secretName: dictystorage-staging-org-tls
```
