Table of Contents
=================

  * [Table of Contents](#table-of-contents)
    * [Requirements](#requirements)
      * [Minikube](#minikube)
      * [kubectl](#kubectl)
      * [helm](#helm)
    * [Deploying applications](#deploying-applications)
      * [Backends](#backends)
        * [PostgreSQL ](#postgresql)
          * [Quick deploy ](#quick-deploy)
          * [Step by step ](#step-by-step)
        * [Arangodb ](#arangodb)
        * [Nats ](#nats)
        * [Object storage(S3 compatible) ](#object-storages3-compatible)
      * [Schema loader ](#schema-loader)
        * [Notes](#notes)
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
      * [HTTPs Ingress ](#https-ingress)
        * [Install cert manager (v0.3.4)](#install-cert-manager-v034)
        * [Generate a self signed certificate](#generate-a-self-signed-certificate)
        * [Create TLS secret](#create-tls-secret)
        * [Issuer and Certificate](#issuer-and-certificate)
        * [Auth ingress](#auth-ingress)
        * [Ingress](#ingress)
      * [Frontend ](#frontend)
        * [Dicty-Stock-Center ](#dicty-stock-center)
  * [Table of Contents](#table-of-contents-1)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)
For additional concepts look [here](deployment/Concept.md)

## Requirements
It is strongly recommended to use a particular version of tool if it mentioned
specifically in the document, otherwise use the latest release.
### Minikube
Minikube runs a single node kubernetes cluster inside a `VM` for testing out
local deployment.
> **Minikube version: v0.25.0**   
> **Kubernetes version: v1.9.0**

* [Install](https://github.com/kubernetes/minikube#installation) minikube.
  Download the specified version and use the `start` command with decent bit of
  memory(at least 4-5GB), cpu(at least 4) and disk space(at least 25-30GB).   

![](images/userinput.png)
>`$_> minikube start --cpus=4 --memory=4096 --disk-size=30g --kubernetes-version=v1.9.0`   

* Enable `heapster` addon for collecting and displaying cluster statistics.
![](images/userinput.png)
> `$_> minikube addons enable heapster`   

### kubectl
Command line client for interacting with kubernetes cluster.
> **version: v1.9.0**
* [Install](https://kubernetes.io/docs/tasks/tools/install-kubectl/) kubectl.
  It is also preferable to enable [shell
  autocompletion](https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)(https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion)
> Note: If you are authorized to use google cloud, then use the bundled kubectl
> that comes with the [gcloud](https://cloud.google.com/sdk/gcloud/) command
> line tool.

### helm
Command line package manager for kubernetes cluster.   
> **version: v2.9.1**
* [Install](https://docs.helm.sh/using_helm/#installing-the-helm-client) helm.
* Run `helm init` to setup interaction with kubernetes for the first time.
* To upgrade helm, reinstall the version and run `helm init --upgrade` only
  to upgrade helm version in kubernetes.

* **Add dictybase helm repository**

![](images/userinput.png)
>`$_> helm repo add dictybase https://dictybase-docker.github.io/kubernetes-charts`

## Deploying applications
### Backends
Make sure you did the following, or at least update the
repositories

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
> `$_> helm install kubernetes-charts/minio -f config.yaml -n minio --namespace dictybase`


### `Schema loader`

![](images/userinput.png)
> `$_> helm install dictybase/dictycontent-schema --namespace dictybase`

![](images/userinput.png)
> `$_> helm install dictybase/dictyuser-schema --namespace dictybase`


**Now to load arangodb schema, first create the following yaml file,**

```yaml
passwords:
  - itisbetweenus
```
![](images/userinput.png)
> `$_> helm install dictybase/arango-schema --namespace dictybase \`   
>                   `--set passwordFile=$(base64 -w0 passwords.yaml)`   

#### Notes
* You might have to run the same chart if there’s a change in database or new
  database/schema being added.


### `API services`

#### `Content`
![](images/userinput.png)
> `$_> helm install dictybase/content-api-server --namespace dictybase \`   
>		`--set apiHost=https://betaapi.dictybase.local`

#### `User`
![](images/userinput.png)
> $_> `helm install dictybase/user-api-server --namespace dictybase \`   
>		`--set apiHost=https://betaapi.dictybase.local`

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
>                        `--set apiHost=https://betaapi.dictybase.local`

#### `Auth`
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
>                `--set apiHost=https://betaauth.dictybase.local`

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
#### `User`
* Start minio web interface, login using `accessKey` and `secretKey` and upload
  the `users.tar.gz` under the import folder. Make sure the file is available
  under `dictybase/import` folder.

![](images/userinput.png)
> `$_> helm install dictybase/load-users --namespace dictybase`
>           `--set s3.accessKey=<minio-access-key>`
>           `--set s3.secretKey=<minio-secret-key>`

#### `Content`
* Get an user id that will be used for loading content, preferably use of the curators id.
* Install [jq](https://stedolan.github.io/jq/) and run the following to get
the user id. Then use that id to run the helm chart.   

![](images/userinput.png)
> `curl --silent http://betaapi.dictybase.local/users\?filter\=email\=@pfey | jq '.data[0].id'`

> `helm install dictybase/content-loader --namespace dictybase --set arguments.user=4216`

#### `Roles and Permissions`
Create a yaml configuration file defining the roles and permissions of one or more users.
```yaml
users:
  - email: email1@email.com
    role:
      name: superuser
      description: A role with superpower
      permission:
        name: admin
        resource: dictybase
        description: A permission with administration access
  - email: tucker@email.com
    role:
      name: genome-editor
      description: A role for editing genomes
      permission:
        name: write
        resource: genome
        description: A permission with write access to genome resource
  - email: caboose@email.com
    role:
      name: curator
      description: A role for curation
      permission:
        name: write
        resource: dictybase
        description: A permission with write access to dictybase resource
```

![](images/userinput.png)
> `$_> helm install dictybase/assign-roles-permissions --namespace dictybase \`   
>       `--set arguments.config=$(base64 -w0 config.yaml)`

#### `Identity`
![](images/userinput.png)
> `$_> helm install dictybase/load-identity --namespace dictybase`
>           `--set arguments.identifier=todd@gmail.com`
>           `--set arguments.provider=google`
>           `--set arguments.email=doodle@hoddle.com`

All three options are required and as usual it can also be fed through a yaml
file. This loader **must be run** after loading the users. Repeat the above
command for loading multiple identities. The `identifier` and `email` arguments
should not be confused, one is provider identity and could be an email of
id(orcid) and the email is the user email that is registered with dictybase.


### `HTTPs Ingress`
[Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#what-is-ingress)
manages external access to services in kubernetes cluster. For minikube, we are
going to map four hosts `https://betatest.dictybase.local`,
`http://betaapi.dictybase.local` `https://betatoken.dictybase.local` and
`https://betaauth.dictybase.local` to various HTTP services. So,
`https://betatest.dictybase.local` will be mapped to frontend,
`https://betaapi.dictybase.local` will be mapped to various services such as
users,contents and `https://betatauth.dictybase.local` will be mapped to auth
service.

![](images/userinput.png)
> `$_> minikube addons enable ingress`   
Have to be done only once.

#### Install cert manager (v0.3.4)   
Make sure you update(`helm repo update`) and check the name of
registered default helm repository(`helm repo list`).   
![](images/userinput.png)
> `$_> helm install kubernetes-charts/cert-manager \`   
> ` --name cert-manager --namespace kube-system \`   
> `--set rbac.create=false`

#### Generate a self signed certificate
CA private key   
![](images/userinput.png)
> `$_> openssl genrsa -out ca.key 2048`

Create a self signed Certificate, valid for a year with the 'signing' option
set. However, self signed certificate might or might not work if generated by
openssl in MacOSX. If it does not, either use a docker container or a linux VM
or watch [this](https://youtu.be/JJTJfl-V_UM?t=399) youtube video.
![](images/userinput.png)
> `$_> openssl req -x509 -new -nodes -key ca.key \`   
>`-subj "/CN=dictybase.local" -days 365 -reqexts v3_req \`   
> `-extensions v3_ca -out ca.crt `

#### Create TLS secret
Save the signing key pair (`ca.key` and `ca.crt`) as a kubernetes `Secret`
resource.   
![](images/userinput.png)
> `$_>  kubectl create secret tls ca-key-pair \`   
>  `--cert=ca.crt --key=ca.key --namespace dictybase`

#### Issuer and Certificate
Save the following yaml say as `issuer.yml` that
references the above secret(ca-key-pair).
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: ca-issuer
  namespace: dictybase
spec:
  ca:
## references the secret.
    secretName: ca-key-pair 
```
Create an `Issuer` resource.   
![](images/userinput.png)
> `$_> kubectl create -f issuer.yml`


Save the following yaml say as `certificate.yml`.
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: dictybase-local
  namespace: dictybase
spec:
  secretName: dictybase-local-tls
  issuerRef:
    name: ca-issuer
    kind: Issuer
  commonName: dictybase.local
  dnsNames:
  - betatest.dictybase.local
  - betatoken.dictybase.local
  - betaauth.dictybase.local
  - betaapi.dictybase.local
```
Create a `Certificate` resource.   
![](images/userinput.png)
> `$_> kubectl create -f certificate.yml`
To update an existing `Certificate` resource.   
![](images/userinput.png)
> `$_> kubectl apply -f certificate.yml`

#### Auth ingress
Save the following yml(auth-config.yml) for https based auth ingress.
```yaml
ingress:
  hosts:
    - name: betaauth.dictybase.local
      paths:
        - path: /authorize
          serviceName: authserver
          servicePort: authserver
  tls:
    - secretName: dictybase-local-tls
      hosts:
        - betaauth.dictybase.local
```

Install 
![](images/userinput.png)
> `$_> helm install dictybase/dictybase-auth-ingress --namespace dictybase \`   
> `$_>  --f auth-config.yaml`

#### Ingress 
First extract the api of authserver.
![](images/userinput.png)
> `$_> minikube service --url authserver --namespace dictybase`
For example it could be `http://192.168.99.100:32509` in a linux box. Use that
in the `auth-url` annotation of ingress configuration and append `/authorize`
to it. 

Save the following yml configuration(config.yml) for https based ingress.
```yaml
ingress:
  annotations:
    nginx.ingress.kubernetes.io/auth-url: http://192.168.99.100:32509/authorize
  hosts:
    - name: betaapi.dictybase.local
      paths:
        - path: /contents
          serviceName: content-api
          servicePort: content-api
        - path: /identities
          serviceName: identity-api
          servicePort: identity-api
        - path: /roles
          serviceName: role-api
          servicePort: role-api
        - path: /users
          serviceName: user-api
          servicePort: user-api
        - path: /permissions
          serviceName: permission-api
          servicePort: permission-api
    - name: betatoken.dictybase.local
      paths:
        - path: /tokens
          serviceName: authserver
          servicePort: authserver
    - name: betatest.dictybase.local
      paths:
        - path: /stockcenter
          serviceName: stock-center
          servicePort: stock-center
        - path: /dictyaccess
          serviceName: dictyaccess
          servicePort: dictyaccess
        - path: /
          serviceName: frontpage
          servicePort: frontpage
  tls: 
    - secretName: dictybase-local-tls
      hosts:
        - betaapi.dictybase.local
        - betatoken.dictybase.local
        - betatest.dictybase.local
```

Now, install the dictybase ingress mapping.   
![](images/userinput.png)
> `$_> helm install dictybase/dictybase-ingress --namespace dictybase \`   
> `$_>  --f config.yaml`

Map the host names to ip address of minikube   
![](images/userinput.png)
> `$_> echo $(minikube ip) betaapi.dictybase.local | sudo tee -a /etc/hosts`   
> `$_> echo $(minikube ip) betatest.dictybase.local | sudo tee -a /etc/hosts`   
> `$_> echo $(minikube ip) betaauth.dictybase.local | sudo tee -a /etc/hosts`   
> `$_> echo $(minikube ip) betatoken.dictybase.local | sudo tee -a /etc/hosts`

The above will allow to access all services by using those hostnames. For example,   
`https://betaapi.dictybase.local/users`   
`https://betaapi.dictybase.local/identities/2`   
`https://betaauth.dictybase.local/tokens/validate`   

__Very very important__   
Run all of the above `https` url(betaapi, betatoken, betatest and betaauth) in
your browser and confirm the security exception so that
the browser does not reject those api call.

### `Frontend`
The default image tag might not reflect the latest image. So, for developmental
version set it up during install or upgrading the charts.
`--set image.tag=dev --set image.pullPolicy=Always`

#### `Dicty-Stock-Center`
![](images/userinput.png)
> `$_> helm install dictybase/dicty-stock-center --namespace dictybase`   

Access the application at `https://betatest.dictybase.local/stockcenter` 
#### `dictyaccess`
![](images/userinput.png)
> `$_> helm install dictybase/dictyaccess --namespace dictybase`

Access the application at `https://betatest.dictybase.local/dictyaccess` 

