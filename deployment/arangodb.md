# ArangoDB
## Prerequisites
* Have a `configured(kubectl access)`
  [GKE](https://cloud.google.com/kubernetes-engine/) access.
* [Setup](/admin.md) cluster admin access.
* [Setup](/storageclass.md) custom storage to use `ssd`.

## Fresh Install
If you are doing a fresh install into the cluster, you need to install two Helm charts. It is recommended 
to use `0.3.11` to start. This version has newly deprecated fields, and our [ArangoDB database chart](https://github.com/dictybase-docker/kubernetes-charts/tree/master/arangodb) 
(`0.0.5`) was designed to reflect these changes.

#### Install [kube-arangodb](https://github.com/arangodb/kube-arangodb/blob/0.3.11/docs/Manual/Deployment/Kubernetes/Helm.md)

First, install the custom resources required by the operators.

![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.11/kube-arangodb-crd.tgz`

Next, install the operator for `ArangoDeployment` while making sure to disable deployment replication.

![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.11/kube-arangodb.tgz `
>                        `--set=DeploymentReplication.Create=false --namespace dictybase`

#### Install our database

![](userinput.png)
>`$_>  helm install dictybase/arangodb --namespace dictybase --set arangodb.dbservers.storageClass=fast --set arangodb.single.storage=50Gi`

It is recommended to set a custom storage class with SSD (see above for info on how to create this) 
and a custom amount of storage. To see what else you can customize, check out the chart [README](https://github.com/dictybase-docker/kubernetes-charts/tree/master/arangodb).

## Upgrade Existing Database
At some point you will need to upgrade your existing database in the cluster. 
Since we initially installed with Helm charts, we will upgrade the same way.

To upgrade the operator to the latest version with Helm, you have to
delete the previous deployment and then install the latest. **HOWEVER**:
You *must not delete* the deployment of the custom resource definitions
(CRDs), or your ArangoDB deployments will be deleted!

Therefore, you have to use `helm ls` to find the deployments for the
operator (`kube-arangodb`) and use `helm delete` to delete them using the
automatically generated deployment names. Here is an example of a `helm
list` output:

```
% helm list
NAME            	REVISION	UPDATED                 	STATUS  	CHART                               	APP VERSION	NAMESPACE
steely-mule     	1       	Sun Mar 31 21:11:07 2019	DEPLOYED	kube-arangodb-crd-0.3.9             	           	default  
vetoed-ladybird 	1       	Mon Apr  8 11:36:58 2019	DEPLOYED	kube-arangodb-0.3.10-preview        	           	default  
```

So here, you would have to do

```bash
helm delete vetoed-ladybird
```

but **not delete `steely-mule`**. See official [README](https://github.com/arangodb/kube-arangodb/blob/master/README.md) for more information.

If wanting to upgrade to several releases ahead, it is advised to upgrade incrementally (i.e. `0.3.8` to `0.3.10` to `0.3.11`, etc.).

#### Upgrade kube-arangodb

Upgrade the existing CRD (optional).

![](userinput.png)
> `$_> helm upgrade [RELEASE NAME] https://github.com/arangodb/kube-arangodb/releases/download/[VERSION]/kube-arangodb-crd.tgz`

Find and delete the existing deployment (as mentioned above).

![](userinput.png)
> `$_> helm delete [RELEASE NAME]`

Next, install the operator for `ArangoDeployment` while making sure to disable deployment replication.

![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/[VERSION]/kube-arangodb.tgz `
>                        `--set=DeploymentReplication.Create=false --namespace dictybase`

Verify that everything is working as expected, then proceed to the next version. 
Repeat as necessary.

#### Getting our latest database

- Update your repositories first

![](userinput.png)
>`$_>  helm repo update`

- Upgrade our database

![](userinput.png)
>`$_>  helm upgrade [RELEASE NAME] dictybase/arangodb --namespace dictybase`

**NOTE:** You can increase storage space of the database but you cannot decrease it (PVC cannot be shrinked). 
If you want to increase space, you must also restart the pod: `kubectl delete pod [POD NAME] -n dictybase`

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

![](userinput.png)
>`$_> helm install dictybase/arango-create-database --namespace dictybase -f new-db.yaml`
