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

