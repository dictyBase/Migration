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
```bash
minikube start --cpus=4 --memory=4096 --disk-size=30g --kubernetes-version=v1.9.0
```
 The above command line is assumed to be for default `Virtualbox` driver. To
 use any other drivers, consult the
 [documentation](https://github.com/kubernetes/minikube#requirements). The
 default `Virtualbox` driver is easy to use and works better across versions.
 The other drivers might requires additional configurations but could provide
 better performance for that particular `OS`.
##### Useful minikube commands 
`minikube ip` - To retrieve the IP of the cluster, useful for accessing software endpoints.   
`minikube logs` - Retrieve logs of running cluster, useful for debugging.   
`minikube service list` - List of available software endpoints in the running cluster. 
#### kubectl
Command line client for interacting with kubernetes cluster.
> **version: v1.9.0**
* [Install](https://kubernetes.io/docs/tasks/tools/install-kubectl/) kubectl.
  It is also preferable to enable [shell
  autocompletion](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)(https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)
> Note: If you are authorized to use google cloud, then use the bundled kubectl
> that comes with the [gcloud](https://cloud.google.com/sdk/gcloud/) command
> line tool.
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

### Deploying applications
#### Concept
Application deployments are managed by grouping them into **virtual application
stack** where every stack provides a particular service(shares similar functions).
In other words, each stack can also be considered as **multi tiered applications.***
Every stack is generally consists of the following core applications 
* **Backend:** Application that provide storage, for example,
[postgresql](http://postgresql.org) database application.
* **API server/middleware/microservice:** Application that provides HTTP(or
grpc) endpoints to access data from the backend based on an specified `API`.
* **Frontend:** A [ReactJS](https://reactjs.org/) based application that runs
in web browser and fetches data through `API sever`.

So, overall a basic stack is organized as 
> **frontend <--> api server <---> backend**.

Now, there are other applications that might be part of some stacks. These are
generally management applications to run one-off task(runs to completion).
* **Schema loader:** Application that loads/manage database schema in the backend.
* **Data loader:** Bootstrap the backend with initial data.
* **Data generator:** Runs bioinformatics analysis of biological data.
#### Strategy
These are steps to deploy an application(backend, frontend etc..)... 
* Containerized the application with docker and make available in docker hub.
The containerized process should be automated with every release of its source
code in github.
* Clone [dictybase chart
repository](https://github.com/dictybase-docker/kubernetes-charts/) and add a
new helm chart for that applicaiton.
* Deploy the chart to kubernetes cluster.
