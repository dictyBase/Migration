# Deployment
Dictybase deployment strategy is inspired by [twelve factor
app](https://12factor.net/) methodology. Our strategy primarily follows these concepts..
* Declarative format for automation, such as [Dockerfile](https://docs.docker.com/engine/reference/builder/).
* Maximum portability across OS, for example both `docker` and `kubernetes`
  could run in all major OS.
* Suitable for deployment on cloud platforms. 
* Minimum divergence between development and production platforms.
* Scaling of applications.


## Strategy
For deploying, all dictyBase softwares are packaged using
[docker](https://docker.io). The packaged(containerized) application are
generally available publicly from [dictybase
repository](https://hub.docker.com/r/dictybase/) of docker hub. Each repository
in the docker hub will be linked to its respective source code in
[github](https://github.com). The github source code and docker hub repository
are linked and the application packages are automatically built from the source
code. The package applications(containerized applcations) are then deployed to
[kubernetes](https://k8s.io) cluster(manages lifecycle of containerized
applications). For development platform of kubernetes, we use
[minikube](https://github.com/kubernetes/minikube/#minikube) and for production
we use [google container engine](https://cloud.google.com/kubernetes-engine/).

## Development platform
It is strongly recommended to use a particular version of tool if it mentioned
specifically in the document, otherwise use the latest release.

### Requirements
#### Minikube
Minikube runs a single node kubernetes cluster inside a `VM` for testing out
local deployment.
> **Minikube version: v0.25.0**   
> **Kubernetes version: v1.9.0**

* [Install](https://github.com/kubernetes/minikube#installation) minikube.
  Download the specified version and use the `start` command with decent bit of
  memory(at least 4-5GB), cpu(at least 4) and disk space(at least 25-30GB).
>$_> `minikube start --cpus=4 --memory=4096 --disk-size=30g --kubernetes-version=v1.9.0`   

 The above command line is assumed to be for default `Virtualbox` driver. To
 use any other drivers, consult the
 [documentation](https://github.com/kubernetes/minikube#requirements). The
 default `Virtualbox` driver is easy to use and works better across versions.
 The other drivers might requires additional configurations but could provide
 better performance for that particular `OS`.
* Enable `heapster` addon for collecting and displaying cluster statistics.
> $_> minikube addons enable heapster   

##### Useful minikube commands 
`minikube dashboard` - Opens up a kubernetes dashboard in the web browser.
`minikube ip` - To retrieve the IP of the cluster, useful for accessing software endpoints.   
`minikube logs` - Retrieve logs of running cluster, useful for debugging.   
`minikube service list` - List of available software endpoints in the running cluster. 
> Usually run minikube kubectl <command> --help to read the manual
#### kubectl
Command line client for interacting with kubernetes cluster.
> **version: v1.9.0**
* [Install](https://kubernetes.io/docs/tasks/tools/install-kubectl/) kubectl.
  It is also preferable to enable [shell
  autocompletion](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)(https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)
> Note: If you are authorized to use google cloud, then use the bundled kubectl
> that comes with the [gcloud](https://cloud.google.com/sdk/gcloud/) command
> line tool.
* Handy kubectl commands...
> kubectl get po and kubectl describe po   
> kubectl get svc and kubectl describe svc   
> kubectl get events   
> kubectl logs   

#### helm
Command line package manager for kubernetes cluster. It used helm chart(yaml
manifests) to deploy containerized applications in kubernetes. Though `kubectl`
can deploy manifests directly to kubernetes, we will use helm for better
management. For our purpose, `kubectl` will primarily be used for retrieving
and configuring information about cluster.
> **version: v2.8.0**
* [Install](https://docs.helm.sh/using_helm/#installing-the-helm-client) helm.
* Run `helm init` to setup interaction with kubernetes for the first time.
* To upgrade helm, reinstall the version and run `helm init --upgrade` only
  to upgrade helm version in kubernetes.
* Some other useful helm commands ....
> helm install   
> helm upgrade   
> helm delete   
> helm list   
> helm repo   
> helm inspect   

* **Add dictybase helm repository**
>$_> `helm repo add dictybase https://dictybase-docker.github.io/kubernetes-charts`

### Deploying applications
#### Concept
Application deployments are managed by grouping them into **virtual application
stack** where every stack provides a particular service(shares similar functions).
In other words, each stack can also be considered as **multi tiered applications.***
Every stack is generally consists of the following core applications 
* **Backend:** Application that provide storage, for example,
[postgresql](http://postgresql.org) database application.
* **API server/middleware/microservice:** Application that provides HTTP(and
grpc) endpoints to access data from the backend based on an specified `API`.
* **Frontend:** A [ReactJS](https://reactjs.org/) based application that runs
in web browser and fetches data through `API sever`.

So, overall a basic stack is organized as 
> **frontend <--> api server <---> backend**.

Now, there are other applications that might be part of some stacks. These are
generally management applications to run one-off tasks(runs to completion).
* **Schema loader:** Application that loads/manage database schema in the
  backend.
* **Data generator:** Generate or pre-process raw data to make it compatible
  for loading. Unless the data is embeddable, it should be  a S3(or compatible)
bucket. For our case we are using [google cloud
storage](https://cloud.google.com/storage/) for production and use
[minio](https://docs.minio.io/) for development.
* **Data loader:** Bootstrap the backend with initial data. Unless the data is
  embeddable, it should be made available from a S3(or compatible) bucket. For
our case we are using [google cloud storage](https://cloud.google.com/storage/)
for production and use [minio](https://docs.minio.io/) for development.
  The generated data is generally loaded in batch.
#### `Deploy Content service stack`
The application stack for managing data from rich text editor frontend. Before you deploy, make sure
* You have added the dictybase helm repository. 
> To confirm   
> $_> helm repo list   
> To check for available dictybase charts   
> $_> helm search -l dicty   
* At least aware about different configuration parameters and their default
  values(if any) of the chart you are deploying. The `README.md` of every
accompanying chart is available
* Always add the `--namespace dictybase` parameters for deploying every chart,
  otherwise they might not work as expected. 
[here](https://github.com/dictybase-docker/kubernetes-charts/)
##### `Backend`
* First create a `yaml` configuration file to setup the passwords for the admin
  and user of database.
```yaml
postgresPassword: somepass...
dictycontentPassword: somepassagain...
```
* Deploy
> $_> helm install dictybase/dictycontent-postgres -f myconfig.yaml --namespace dictybase   

It will print out bunch of commands about how to gather information about chart
from the command line. The easy way will be to use web based kubernetes
dashboard(remember `minikube dashboard` command) and look under the `dictybase` namespace.

* Wait for 14-19 seconds for the database to get ready for the first time. Have
  two sips of coffee or any other beverages. 
* Run the following to check for ip, kind of tells you that it’s running at least.
> $_> minikube service --url dictycontent-backend --namespace dictybase
Expect an output something like this...
`http://192.168.99.100:30372`

Alternatively, check for the pod status in the kubernetes dashboard which will
look like similar to this
![dashboard-pod](https://user-images.githubusercontent.com/48740/35778877-2482c5d4-098a-11e8-96e7-d1c2b42b51ef.png).
There might be only one pod and they should have a green tick mark, otherwise
the deployment is probably botched.



##### `Schema loader`
* Deploy
> $_> helm install dictybase/dictycontent-schema --namespace dictybase

* Wait for 3-5 seconds.
##### `API server`
* Deploy
> $_> helm install dictybase/dictycontent-api-server --namespace dictybase   

It should start instantly. Run the following check for its endpoint..
> $_> minikube service --url dictycontent-backend --namespace dictybase   

Make sure you note down its port number to use it for the next command.

You could verify it by checking its `/healthz` endpoint...
> $_> curl -i $(minikube ip):<port number>/healthz   
>   The above should return a successful HTTP response.

Alternatively, you could for check for the `pods` log in the dashboard which is
expected to look like this ![192 168 99 100-30000- laptop with hidpi
screen](https://user-images.githubusercontent.com/48740/35778408-739c043e-0983-11e8-8a99-12c84d17b0c1.png)

After this, read the [content api](https://dictybase.github.io/dictybase-api/)
specification for data loading and to use in frontend application.

> Use the http ip address(including port number) for testing with your frontend.

##### `Data generator`
It will generate the serialized json from the existing html pages to be loaded
by the `data loader`. Depending on the size, it might be loaded to a s3 compatible storage.
##### `Data loader`
It will use the [content api](https://dictybase.github.io/dictybase-api/) and
load the serialized json from a s3 compatible storage(depending on the size).
##### `Frontend`
There will be multiple frontend applications using this stack, so their
deployment information will be linked from here. At this point,
[Dicty-Stock-center](https://github.com/dictyBase/Dicty-Stock-Center/) and
[Genomepage](https://github.com/dictyBase/genomepage/) are few of the potential
consumers for this stack.
