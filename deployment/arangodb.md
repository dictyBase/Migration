# ArangoDB
## Prerequisites
* Have a `configured(kubectl access)`
  [GKE](https://cloud.google.com/kubernetes-engine/) access.
* [Setup](admin.md) cluster admin access.
* [Setup](storageclass.md) custom storage class to use `ssd` disk.
* This guide assumes only one arangodb server instance for each cluster.

## Fresh Install
### Arangodb custom resource definition(CRD)
> **version: 0.3.11**`   

Install two charts, a `CRD` and `deployment controllter`.

> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.11/kube-arangodb-crd.tgz`   
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.11/kube-arangodb.tgz `
>                        `--set=DeploymentReplication.Create=false --namespace dictybase`

In the second step we are disable deployment replication. For details look
[here](https://github.com/arangodb/kube-arangodb/blob/0.3.11/docs/Manual/Deployment/Kubernetes/Helm.md)

### Install arangodb server
>`$_>  helm repo update`    
>`$_>  helm install dictybase/arangodb --namespace dictybase \ `    
>         `--set arangodb.dbservers.storageClass=fast \ `   
>         ` --set arangodb.single.storage=50Gi`

Here we have use the custom [storage class](storageclass.md) and have also
setup the storage space. Arangodb version `3.3.23` is also get install by
default. To see what else you can customize, check out the chart
[README](https://github.com/dictybase-docker/kubernetes-charts/tree/master/arangodb).

## Upgrade existing arangodb server
### Remove deployment(NOT CRD)
At some point you will need to upgrade your existing database in the cluster. 
Since we initially installed with Helm charts, we will upgrade the same way.

To upgrade the operator to the latest version with Helm, you have to
delete the previous deployment and then install the latest. **HOWEVER**:
You *must not delete* the custom resource definitions
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
Make sure **not to delete `steely-mule`**. See official
[README](https://github.com/arangodb/kube-arangodb/blob/master/README.md) for
more information. If wanting to upgrade to several releases ahead, it is
advised to upgrade incrementally (i.e. `0.3.8` to `0.3.10` to `0.3.11`, etc.).

### Upgrade CRD and install new Deployment
Upgrade the existing CRD (optional).
> `$_> helm upgrade [RELEASE NAME] \`    
>   `https://github.com/arangodb/kube-arangodb/releases/download/[VERSION]/kube-arangodb-crd.tgz`

Find and delete the existing deployment (as mentioned above).
> `$_> helm delete [RELEASE NAME]`

Next, install the operator for `ArangoDeployment` while making sure to disable deployment replication.
> `$_> helm install \`       
>      `https://github.com/arangodb/kube-arangodb/releases/download/[VERSION]/kube-arangodb.tgz `    
>      `                  `--set=DeploymentReplication.Create=false --namespace dictybase`

Verify that everything is working as expected, then proceed to the next version. 
Repeat as necessary.

### Upgrade server instance
By default the chart will install the arangodb version `3.3.23`. To use another,
pick up a different version from
[here](https://hub.docker.com/_/arangodb/?tab=tags)

>`$_>  helm repo update`   
>`$_>  helm upgrade [RELEASE NAME] dictybase/arangodb \`    
>        `--set=image.tag=[VERSION] --namespace dictybase`

##### Very important notes
* Storage space of the database can only be increased, decreasing it is not be
  possible(apparently PVC cannot be shrinked) The pod must be restarted to increase the storage.
> $_> `kubectl delete pod [POD NAME] -n dictybase`
* Use the helm chart directly to upgrade for patch version(3.3.11 -> 3.3.23).
  To upgrade the minor version(3.3.23 -> 3.4.5), you should backup and restore
  the database content in addition to the helm chart upgarde process.

## Create new databases(in existing server instance)
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

Just add more database names in the `names` parameters, existing one will be
skipped and new ones will be created.
