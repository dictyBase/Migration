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
These details are coming soon.

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