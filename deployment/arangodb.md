# ArangoDB

## Fresh Install
If you are doing a fresh install into the cluster, you can use Helm charts.

- Install [kube-arangodb](https://github.com/arangodb/kube-arangodb/blob/0.3.8/docs/Manual/Deployment/Kubernetes/Helm.md)
![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.8/kube-arangodb-crd.tgz`
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.8/kube-arangodb.tgz \`
>                        `--set=DeploymentReplication.Create=false --namespace dictybase`

- Install our database
![](userinput.png)
>`$_>  helm install dictybase/arangodb --namespace dictybase`

## Upgrade Existing Database
If you need to upgrade an existing database in the cluster, it is advised to use `kubectl`. Use their [official
manifests](https://raw.githubusercontent.com/arangodb/kube-arangodb/0.3.8/manifests/arango-deployment.yaml), but 
make sure to replace the namespace as necessary. In this example, we use a customized version (available in this
directory) that uses the `dictybase` namespace.

Using Helm to upgrade requires deleting the previous deployment. With `kubectl` you just need to
apply the desired upgrade. See official [README](https://github.com/arangodb/kube-arangodb/blob/master/README.md).

- Install [kube-arangodb]
![](userinput.png)
> `$_> kubectl apply -f https://raw.githubusercontent.com/arangodb/kube-arangodb/0.3.8/manifests/arango-crd.yaml`
> `$_> kubectl apply -f arango-deployment.yaml`

- Get our latest chart
![](userinput.png)
>`$_>  helm repo update`

Upgrade our database
![](userinput.png)
>`$_>  helm upgrade [RELEASE NAME] dictybase/arangodb --namespace dictybase`

## Create new databases

- Make yaml config file (new-db.yaml)

```yaml
database:
  names:
    - auth
    - order
    - stock
  user: george
  password: costanza
  grant: rw
```

>`$_> helm install dictybase/arango-create-database --namespace dictybase -f new-db.yaml`