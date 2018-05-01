Table of Contents
=================

  * [Deployment](#deployment)
    * [Strategy](#strategy)
    * [Development platform](#development-platform)
      * [Requirements](#requirements)
        * [Minikube](#minikube)
          * [Useful minikube commands](#useful-minikube-commands)
        * [kubectl](#kubectl)
        * [helm](#helm)
    * [Deploying applications](#deploying-applications)
      * [Concept](#concept)
      * [Common checklist and steps for installing charts](#common-checklist-and-steps-for-installing-charts)
      * [Backends](#backends)
        * [PostgreSQL ](#postgresql)
          * [Quick deploy ](#quick-deploy)
          * [Step by step ](#step-by-step)
        * [Arangodb ](#arangodb)
        * [Nats ](#nats)
        * [Object storage(S3 compatible) ](#object-storages3-compatible)
      * [Schema loader ](#schema-loader)
        * [Notes](#notes)
      * [Ingress ](#ingress)
      * [API services ](#api-services)
        * [Content ](#content)
        * [User ](#user)
        * [Identity ](#identity)
        * [Auth ](#auth)
        * [Notes](#notes-1)
      * [Data generator ](#data-generator)
      * [Data loader ](#data-loader)
        * [Content ](#content-1)
        * [User ](#user-1)
        * [Roles and Permissions ](#roles-and-permissions)
        * [Identity ](#identity-1)
      * [Frontend ](#frontend)
  * [Table of Contents](#table-of-contents-1)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

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

![](images/userinput.png)
>`$_> minikube start --cpus=4 --memory=4096 --disk-size=30g --kubernetes-version=v1.9.0`   

 The above command line is assumed to be for default `Virtualbox` driver. To
 use any other drivers, consult the
 [documentation](https://github.com/kubernetes/minikube#requirements). The
 default `Virtualbox` driver is easy to use and works better across versions.
 The other drivers might requires additional configurations but could provide
 better performance for that particular `OS`.
* Enable `heapster` addon for collecting and displaying cluster statistics.


![](images/userinput.png)
> `$_> minikube addons enable heapster`   

##### Useful minikube commands 
`minikube dashboard` - Opens up a kubernetes dashboard in the web browser.
`minikube ip` - To retrieve the IP of the cluster, useful for accessing software endpoints.   
`minikube logs` - Retrieve logs of running cluster, useful for debugging.   
`minikube service list` - List of available software endpoints in the running cluster. 

![](images/userinput.png)
> Usually run `minikube kubectl <command> --help` to read the manual

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

![](images/userinput.png)
>`$_> helm repo add dictybase https://dictybase-docker.github.io/kubernetes-charts`

## Deploying applications
### Concept
Application deployments are managed by grouping them into **virtual application
stack** where every stack provides a particular service(shares similar functions).
In other words, each stack can also be considered as **multi tiered applications.***
Every stack is generally consists of the following core applications 
* **Backend:** Application that provide storage, for example,
[postgresql](http://postgresql.org) database application.
* **API server/middleware/microservice:** Application that provides HTTP(and
grpc) endpoints to access data from the backend based on an specified `API`.
* **Frontend:** A [ReactJS](https://reactjs.org/) based application that runs
in a web browser and fetches data through `API server`.

So, overall a basic stack is organized as 
> **frontend <--> api server <---> backend**.

Now, there are other applications that might be part of some stacks. These are
generally management applications to run one-off tasks(runs to completion).
* **Schema loader:** Application that loads/manage database schema in the
  backend.
* **Data generator:** Generate or pre-process raw data to make it compatible
  for loading. Unless the data is embeddable, it should be  a S3(or compatible)
bucket. For our case we are using  [minio](https://docs.minio.io/) for
production and development.
* **Data loader:** Bootstrap the backend with initial data. Unless the data is
  embeddable, it should be made available from a S3(or compatible) bucket. For
our case we are using [minio](https://docs.minio.io/) for production and
development.The generated data is generally loaded in batch.

### Common checklist and steps for installing charts

* Make sure you have added the correct repositories. If not, add them with
  `helm repo add` command.

![](images/userinput.png)
> `$_> helm repo list`   

* Check for available dictybase charts   

![](images/userinput.png)
> `$_> helm search -l dicty`   

* Update repositories   

![](images/userinput.png)
> `$_> helm repo update`   


* Always add the `--namespace dictybase` parameters for deploying every chart,
  otherwise they might not work as expected. 

* At least aware about different configuration parameters and their default
  values(if any) of the chart you are deploying. The `README.md` of every
accompanying chart is available
[here](https://github.com/dictybase-docker/kubernetes-charts/). If no
`README.md` is available, read through the `values.yaml` file, it is generally
more or less annotated for understanding.

* In addition, use `helm inspect <chart-name>` to check for all configurable options.

* Configuration parameters could be set either from command line `--set
  something=xxxx` or through a yaml file or a combination of both.

### Backends
Make sure you did the following, or at least update the repositories


#### `PostgreSQL`
The postgreSQL backend is currently used by following api services.   
+ user-api
+ content-api

##### `Quick deploy`

![](images/userinput.png)
```shell
$_> helm install dictybase/dictycontent-postgres --namespace dictybase \
		--set postgresPassword=somepass...  \
		--set dictycontentPassword=someotherpass.. \ 
		--set dictyuserPassword=someotherpass.. \ 
```

For detail understanding of the deploy process read the sections below.

##### `Step by step`
* First create a `yaml` configuration file to setup the passwords for the admin
  and user of database.

![](images/userinput.png)
```yaml
postgresPassword: somepass...
dictycontentPassword: somepassagain...
dictyuserPassword: somepassagain...
```
Remember you could also change the default name of the databases and users
through configuration parameters.

![](images/userinput.png)
> `$_> helm install dictybase/dictycontent-postgres -f myconfig.yaml --namespace dictybase`   

It will print out bunch of commands about how to gather information about chart
from the command line. The easy way will be to use web based kubernetes
dashboard(remember `minikube dashboard` command) and look under the `dictybase` namespace.

* Wait for 14-19 seconds for the database to get ready for the first time. Have
  two sips of coffee or any other beverages. 
* Run the following to check for ip, kind of tells you that it’s running at least.

![](images/userinput.png)
> `$_> minikube service --url dictycontent-backend --namespace dictybase`

Expect an output something like this...   
`http://192.168.99.100:30372`

Alternatively, check for the pod status in the kubernetes dashboard which will
look like similar to this
![dashboard-pod](https://user-images.githubusercontent.com/48740/35778877-2482c5d4-098a-11e8-96e7-d1c2b42b51ef.png).
There might be only one pod and they should have a green tick mark, otherwise
the deployment is probably botched.


#### `Arangodb`
Arangodb backend is currently used by following api services.   
+ identity-api 

![](images/userinput.png)
> `$_> helm install dictybase/arango-operator --namespace dictybase`   

![](images/userinput.png)
> `$_> helm install dictybase/arangodb --namespace dictybase`   

#### `Nats`
[Nats](https://nats.io) is the default messaging backend.

![](images/userinput.png)
> `$_> helm install dictybase/nats-operator --namespace dictybase`   

![](images/userinput.png)
> `$_> helm install dictybase/nats --namespace dictybase`   

#### `Object storage(S3 compatible)`
* Make a yaml configuration file 
```yaml
mode: standalone
persistence:
	enabled: true
	# the size is configurable
	size: 6Gi 
service:
	type: NodePort
defaultBucket:
  enabled: true
  name: dictybase
  policy: none
  purge: false
# It is kind of username and password
# you can use it to login from the web interface and manage files
accessKey: ANYTHINGYOUWANT
secretKey: ITISASECRET
```

* You could read about all configuration parameters by running   

![](images/userinput.png)
> `$_> helm inspect kubernetes-charts/minio`

* or go [here](https://hub.kubeapps.com/charts/stable/minio)

* Install the chart

![](images/userinput.png)
> `$_> helm install kubernetes-charts/minio -f config.yaml --namespace dictybase`


### `Schema loader`

![](images/userinput.png)
> `$_> helm install dictybase/dictycontent-schema --namespace dictybase`

![](images/userinput.png)
> `$_> helm install dictybase/dictyuser-schema --namespace dictybase`

```yaml
database:
  name: auth
  user: dictybase
  password: itisbetweenus   
collection:
  name: identity
```
![](images/userinput.png)
> `$_> helm install dictybase/arango-database -f config.yaml --namespace dictybase`

![](images/userinput.png)
> `$_> helm install dictybase/arango-collection -f config.yaml --namespace dictybase`

#### Notes
* You might have to run the same chart if there’s a change in database or new
  database/schema being added.

### `Ingress`
[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress)
manages external access to services in kubernetes cluster. For minikube, we are
going to map two hosts `betatest.dictybase.local` and
`betaauth.dictybase.local` to various HTTP services. So,
`betatest.dictybase.local` will be mapped to various services such as
users,contents and `betatauth.dictybase.local` will be mapped to auth service.

![](images/userinput.png)
> `$_> minikube addons enable ingress`   
Have to be done only once.

Now, install the dictybase ingress mapping.
![](images/userinput.png)
> `$_> helm install dictybase/dictybase-ingress --namespace dictybase`

Map the host names to ip address of minikube   
![](images/userinput.png)
> `$_> echo $(minikube ip) betatest.dictybase.local | sudo tee -a /etc/hosts`

> `$_> echo $(minikube ip) betaauth.dictybase.local | sudo tee -a /etc/hosts`

Extract the port number on which the ingress is available.   
![](images/userinput.png)
> `minikube service -n kube-system --url --format "{{.Port}}" default-http-backend`   

The port number might be different from machine to machine, for mine it’s 300001.
Make sure to remember that, it will be used for deploying all the services. For
production, it is generally deployed it default port 80, so mentioning that
implicitly is required only for local system.

The above will allow to access all services by using those hostnames. For example,
`http://betatest.dictybase.local:300001/users`
`http://betatest.dictybase.local:300001/identities/2`
`http://betaauth.dictybase.local:300001/tokens/validate`

### `API services`

#### `Content`
![](images/userinput.png)
> `$_> helm install dictybase/content-api-server --namespace dictybase \`   
>		`--set apiHost=http://betatest.dictybase.local:300001`

#### `User`
![](images/userinput.png)
> $_> `helm install dictybase/user-api-server --namespace dictybase \`   
>		`--set apiHost=http://betatest.dictybase.local:300001`

#### `Identity`
```yaml
database:
  name: auth
  user: dictybase
  password: itisbetweenus   
collection:
  name: identity
```
![](images/userinput.png)
> `$_> helm install dictybase/identity-api-server -f config.yaml --namespace dictybase \`   
>                        `--set apiHost=http://betatest.dictybase.local:300001`

#### `Auth`
* You have `openssl` and `base64` available in your command
  line. If they are installed, running them should print out
  their usage help, otherwise you will get `command not found`. If
  it’s the later case, install the program **before proceeding any
  further.** Generally, they are installed by default for latest Mac
  and linux OS.

* Generate public and private keys. If you run the following
  commands, the `app.rsa` will be the private key.
* Note: need to create keys folder for the below commands to work

![](images/userinput.png)
> `$_> openssl genrsa -out keys/app.rsa 2048`   
> `$_> openssl rsa -in keys/app.rsa -pubout -out keys/app.rsa.pub`

* Create configuration file for oauth providers as described
  [here](https://github.com/dictyBase/authserver#create-configuration-file). Go
  [here](https://github.com/dictyBase/authserver/tree/develop#supported-providers)
  to set up client secrets for all the supported providers. However, for
  developmental purposes, one or two providers should be a good start.

* **Deploy** the chart. The command assumes your private key to be `app.rsa`,
  public key is in `app.rsa.pub` and configuration file is `app.json`. Those
  name are not mandatory, if they are in differently named files, change the
  command accordingly.

![](images/userinput.png)
> `$_> helm install --namespace dictybase --set publicKey=$(base64 -w0 app.rsa.pub) \`   
>                `--set privateKey=$(base64 -w0 app.rsa) \`   
>                `--set configFile=$(base64 -w0 app.json) dictybase/authserver \`   
>                `--set apiHost=http://betaauth.dictybase.local:300001`

#### Notes
* For MacOS, you either need to remove the `-w0` references from the above
  command or change `base64` to `gbase64` if GNU CoreUtils is installed.   
* All services should start instantly. Run the following check for its endpoint..   

![](images/userinput.png)
> ```$_> minikube service list -n dictybase```   
> ```$_> minikube service --url <service-name> -n dictybase```   

Make sure you note down its port number to use it for the next command.

* You could verify it by checking its `/healthz` endpoint...

![](images/userinput.png)
> ```$_> curl -i $(minikube ip):<port number>/healthz```   

`The above should return a successful HTTP response.`

* Alternatively, you could for check for the `pods` log in the dashboard which
  is expected to look like this ![192 168 99 100-30000- laptop with hidpi
screen](https://user-images.githubusercontent.com/48740/35778408-739c043e-0983-11e8-8a99-12c84d17b0c1.png)

### `Data generator`
Nothing here.

### `Data loader`
#### `Content`
WIP
#### `User`
* Start minio web interface, login using `accessKey` and `secretKey` and upload
  the `users.tar.gz` under the import folder. Make sure the file is availabe
  under `dictybase/import` folder.

![](images/userinput.png)
> `$_> helm install dictybase/load-users --namespace dictybase`
>           `--set s3.accessKey=<minio-access-key>`
>           `--set s3.secretKey=<minio-secret-key>`
#### `Roles and Permissions`
WIP
#### `Identity`
WIP

### `Frontend`
Nothing here.



