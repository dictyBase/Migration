# ArangoDB

First of all, make sure that you have set up a cluster admin role for the current executing user.
To get the email of the current user: `gcloud info | grep Account`.

Now create the clusterrolebinding.

```
kubectl create clusterrolebinding dictyadmin \
    --clusterrole=cluster-admin \
    --user=youremail@email.org
```

This should allow you to easily install future manifests. *However,* if you get a "forbidden" error
when creating a new role, read the error message and verify that the user email address is the same 
one that you used to create this `cluster-admin`. Be especially mindful that the capitalization is the 
same for both (i.e. `testuser@gmail.com` and `TestUser@gmail.com` are **not** the same).

## Fresh Install
If you are doing a fresh install into the cluster, you need to install two Helm charts. For this example,
we are going to start by deploying version `0.3.8`.

#### Install [kube-arangodb](https://github.com/arangodb/kube-arangodb/blob/0.3.8/docs/Manual/Deployment/Kubernetes/Helm.md)

First, install the custom resources required by the operators.

![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.8/kube-arangodb-crd.tgz`

Next, install the operator for `ArangoDeployment` while making sure to disable deployment replication.

![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.8/kube-arangodb.tgz \`
>                        `--set=DeploymentReplication.Create=false --namespace dictybase`

#### Install our database

![](userinput.png)
>`$_>  helm install dictybase/arangodb --namespace dictybase`

To see what you can customize (i.e. storage class, etc.), check out the [README](https://github.com/dictybase-docker/kubernetes-charts/tree/master/arangodb).

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

Next, pick an intermediary release to upgrade to. We will select `0.3.10`.

#### Install [kube-arangodb](https://github.com/arangodb/kube-arangodb/blob/0.3.10/docs/Manual/Deployment/Kubernetes/Helm.md)

Upgrade the existing CRD.

![](userinput.png)
> `$_> helm upgrade [RELEASE NAME] https://github.com/arangodb/kube-arangodb/releases/download/0.3.10/kube-arangodb-crd.tgz`

Find and delete the existing deployment (as mentioned above).

![](userinput.png)
> `$_> helm delete [RELEASE NAME]`

Next, install the operator for `ArangoDeployment` while making sure to disable deployment replication.

![](userinput.png)
> `$_> helm install https://github.com/arangodb/kube-arangodb/releases/download/0.3.10/kube-arangodb.tgz \`
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

To see what you can customize (i.e. storage class, etc.), check out the [README](https://github.com/dictybase-docker/kubernetes-charts/tree/master/arangodb).

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