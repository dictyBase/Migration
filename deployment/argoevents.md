Table of Contents
=================

  * [Prerequisites](#prerequisites)
  * [Helm Charts Installation](#helm-charts-installation)
      * [Create cluster role for Argo Events service account](#create-cluster-role-for-argo-events-service-account)
  * [Issuer and Certificate](#issuer-and-certificate)
  * [Understanding Argo Events](#understanding-argo-events)
      * [Gateways](#gateways)
      * [Event Sources](#event-sources)
      * [Sensors](#sensors)
  * [GitHub Setup](#github-setup)
      * [Enable Ingress](#enable-ingress)
      * [Enable GitHub Webhooks](#enable-github-webhooks)
      * [Generate GitHub personal access token (apiToken)](#generate-github-personal-access-token-apitoken)
      * [Generate Kubernetes secret](#generate-kubernetes-secret)
      * [Gateway](#gateway)
      * [Event Source](#event-source)
      * [Sensor](#sensor)
        * [Helpful Links](#helpful-links)
  * [Minio Setup](#minio-setup)
      * [Kubernetes Secret](#kubernetes-secret)
      * [Gateway](#gateway-1)
      * [Event Source](#event-source-1)
      * [Sensor](#sensor-1)
        * [Helpful Links](#helpful-links-1)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

Here we will go through the process of setting up Argo Events in a cluster. Our 
goals in using these tools are twofold:

1) Connect Argo Events (webhooks) to capture triggers from our source code 
repositories (i.e. commits).

2) Connect Argo Events to capture `POST` and `PUT` requests to a Minio bucket -- 
anything that creates a new file or updates existing files.

## Prerequisites
* Have a `configured (kubectl access)`
  [GKE](https://cloud.google.com/kubernetes-engine/) access.
* [Setup](admin.md) cluster admin access.
* [Cert-Manager](certificate.md) installed.
* [Minio](minio.md) installed.

## Helm Charts Installation

The official Argo helm charts will do an installation with all of the necessary 
custom resource definitions, configmaps and controllers required to run both Argo 
and Argo Events.

- First create namespaces

![](userinput.png)
> `$_> kubectl create namespace argo`

![](userinput.png)
> `$_> kubectl create namespace argo-events`

- Add `argoproj` repository

![](userinput.png)
> `$_> helm repo add argo https://argoproj.github.io/argo-helm`

- Install `argo` chart

![](userinput.png)
> `$_> helm install argo/argo --version 0.4.0 --namespace argo`

- Install `argo-events` chart

![](userinput.png)
> `$_> helm install argo/argo-events --version 0.4.2 --namespace argo-events`

### Create cluster role for Argo Events service account

The `argo` Helm chart installs everything needed; however, its service account 
needs to have additional permissions. Run the following to do so:

>`$_>  kubectl create clusterrolebinding argo-events \ `     
>         `--clusterrole=cluster-admin \ `     
>         `--serviceaccount=argo-events:default`

## Issuer and Certificate

You will need to create a new issuer and certificate -- these are required in 
order to set up Ingress (our next step).

__Issuer__
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Issuer
metadata:
  name: argo-eric-dev
  namespace: argo-events
spec:
  acme:
    # The ACME server URL
    server: https://acme-v02.api.letsencrypt.org/directory
    # Email address used for ACME registration
    email: YOUR EMAIL HERE....
    # Name of a secret used to store the ACME account private key
    privateKeySecretRef:
      name: argo-eric-dev
    # Enable the HTTP-01 challenge provider
    http01: {}
```

![](userinput.png)
> `$_> kubectl apply -f issuer.yml`

__Certificate__
```yaml
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: dictyargo-eric-dev
  namespace: argo-events
spec:
  secretName: argo-eric-dev-tls
  issuerRef:
    kind: Issuer
    name: argo-eric-dev
  dnsNames:
    - ericargo.dictybase.dev
  acme:
    config:
      - http01:
          ingressClass: nginx
        domains:
          - ericargo.dictybase.dev
```

![](userinput.png)
> `$_> kubectl apply -f certificate.yaml`

## Understanding Argo Events

Three pieces are required for Argo Events and they need to be deployed in this 
exact order.

### Gateways

Gateways are responsible for consuming events from event sources and then 
dispatching them to sensors. There are [many types](https://argoproj.github.io/argo-events/gateway/#core-gateways) 
of gateways. Each gateway has two components, a client and a server, and these 
use gRPC to communicate. The server consumes events and streams them to the client, 
which transforms the events and dispatches them to sensors.

<p align="center">
  <img src="https://github.com/argoproj/argo-events/blob/master/docs/assets/gateways.png?raw=true" alt="Gateway"/>
</p>

One gateway can have multiple sensors, as denoted by the `watchers` key at the 
bottom of its config file.

```yaml
  watchers:
    sensors:
      - name: "github-sensor"
      # insert any other sensors here
```

Because of this, only one gateway is needed for each use case. Since we have two 
use cases (GitHub webhooks and Minio notifications), we will need to create two 
gateways (one for each).

### Event Sources

Event sources are config maps that are interpreted by the gateway.

Each event source has its own type of configuration. For GitHub webhooks, you 
would need to specify the webhook ID, GitHub repository, the actual hook 
endpoint/port and the tokens from the K8s secret. For Minio, you would need to 
provide the s3 service endpoint, bucket name, events and the keys from the K8s
secret.

Here's a fragment example of how to create a GitHub event source with name `dicty-stock-center`. This same template would need to be used and customized 
for every repository we want to connect.

```yaml
  dicty-stock-center: |-
    id: 99999
    owner: "dictyBase"
    repository: "Dicty-Stock-Center"
    hook:
     endpoint: "/github/dicty-stock-center"
     port: "12000"
     url: "https://ericargo.dictybase.dev"
    events:
    - "push"
    apiToken:
      name: github-tokens
      key: apiToken
    webHookSecret:
      name: github-tokens
      key: webHookSecret
    insecure: false
    active: true
    contentType: "json"
```

You can include multiple events in the same config file. Just use the same 
template but change the name accordingly (i.e. `dicty-frontpage`, etc).

For a comparison, here's how you would define an event source for Minio:

```yaml
  minio-example: |-
    bucket:
      name: input
    # s3 service endpoint
    endpoint: minio.dictybase:9000
    events:
     - s3:ObjectCreated:Put
     - s3:ObjectCreated:Post
    # no filter needed
    filter:
      prefix: ""
      suffix: ""
    insecure: true
    accessKey:
      key: accesskey
      name: minio
    secretKey:
      key: secretkey
      name: minio
```

### Sensors

Sensors define a set of event dependencies (inputs) and triggers (outputs). 
Triggers are executed once the event dependencies are resolved.

<p align="center">
  <img src="https://raw.githubusercontent.com/argoproj/argo-events/master/docs/assets/sensor.png?raw=true" alt="Sensor"/>
</p>

An event dependency is the event the sensor is waiting for. It is defined as 
`gateway-name:event-source-name`. For example, if you created an `event-source` 
with the name `dicty-stock-center`, the event dependency name would be 
`github-gateway:dicty-stock-center`.

Each sensor can have multiple events defined. First you would need to list their 
names under the `spec.dependencies` key like so:

```yaml
  dependencies:
    - name: "github-gateway:dicty-stock-center"
    - name: "github-gateway:dicty-frontpage"
```

You would also need to update the `resourceParameters` key to link the events 
and the values you want to grab from them. A brief GitHub example that grabs the 
head commit URL from the webhook response of two different repositories:

```yaml
      resourceParameters:
        - src:
            event: "github-gateway:dicty-stock-center"
            path: "head_commit.url"
            # value:
          dest: spec.arguments.parameters.0.value
        - src:
            event: "github-gateway:dicty-frontpage"
            path: "head_commit.url"
            # value:
          dest: spec.arguments.parameters.0.value
```

For the triggers, you have to set up an [Argo Workflow](https://argoproj.github.io/docs/argo/examples/readme.html).

There are more full examples of these in the GitHub and Minio sections below.

## GitHub Setup

In order to integrate GitHub webhooks with Argo Events, we will need to enable 
Ingress, create a personal access token and set up all of our wanted webhooks.

### Enable Ingress

Ingress is necessary in order to get the service URL that exposes the gateway 
server and makes it reachable from GitHub.

- Make ingress yaml file (`ingress-gh.yaml`)

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  annotations:
    kubernetes.io/ingress.class: nginx
  name: github-gateway-svc
  namespace: argo-events
spec:
  rules:
  - host: ericargo.dictybase.dev
    http:
      paths:
      - backend:
          serviceName: github-gateway-svc
          servicePort: 12000 # need to explicitly define this
        path: /github
  tls:
  - hosts:
    - ericargo.dictybase.dev
    secretName: argo-eric-dev-tls
```

### Enable GitHub Webhooks

There are two ways to create a personal access token -- either through the command 
line or on GitHub. This guide will use the command line to create a webhook.

First, create a secret key. This can be anything you want, and it is important 
to keep track of this since it will be needed when creating an event source.

A helpful way to generate a secret key is by using the following command in the 
terminal:

`ruby -rsecurerandom -e 'puts SecureRandom.hex(20)'`

**Important:** Make note of this secret key -- you will need it to create an 
event source.

Create a JSON file (say `payload.json`) with the desired configuration for the 
webhook. The URL value should be the webhook endpoint you will use later when 
creating an event source. Our standard format is to use `/github/:repo-name`.

```json
{
  "name": "web",
  "active": true,
  "events": ["push"],
  "config": {
    "url": "https://ericargo.dictybase.dev/github/dicty-stock-center",
    "content_type": "json",
    "insecure_ssl": "0",
    "secret": "YOUR_SECRET_HERE"
  }
}
```

Now `POST` this using [curl](https://curl.haxx.se/).

![](userinput.png)
>`$_> curl -X POST -H "Content-Type: application/json" -u YOUR_USERNAME_HERE \`     
> `-d @payload.json https://api.github.com/repos/:owner/:repo/hooks`

**Note:** if you have [two-factor authentication](https://help.github.com/en/articles/securing-your-account-with-two-factor-authentication-2fa) 
enabled, you will also need to include your 2FA code with the following:

`--header "x-github-otp: YOUR_CODE_HERE"`

After using the `curl` command above, you will be prompted for your account 
password. If successful you will receive a response like this:

```json
{
  "type": "Repository",
  "id": 12345678,
  "name": "web",
  "active": true,
  "events": [
    "push",
  ],
  "config": {
    "content_type": "json",
    "insecure_ssl": "0",
    "url": "https://example.com/webhook"
  },
  "updated_at": "2019-06-03T00:57:16Z",
  "created_at": "2019-06-03T00:57:16Z",
  "url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678",
  "test_url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678/test",
  "ping_url": "https://api.github.com/repos/octocat/Hello-World/hooks/12345678/pings",
  "last_response": {
    "code": null,
    "status": "unused",
    "message": null
  }
}
```

**IMPORTANT: copy the `id` value immediately.** This is your webhook ID, and it 
is needed for generating a Kubernetes secret very soon.

### Generate GitHub personal access token (apiToken)

If you already have a personal access token that you want to use, you can skip 
this part. However, it may be preferable to generate a new token specifically for 
Argo usage.

There are two ways to create a personal access token -- either through the command 
line or on [GitHub](https://github.com/settings/tokens). In this guide, we will 
use the command line.

Create a JSON file (say `token.json`) with, at minimum, the `scopes` and `note` 
for this token. See [here](https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization) 
for more information on available parameters.
```json
{
  "scopes": [
    "repo"
  ],
  "note": "argo events"
}
```

Now `POST` this using [curl](https://curl.haxx.se/).

![](userinput.png)
>`$_> curl -X POST -H "Content-Type: application/json" -u YOUR_USERNAME_HERE \`     
> `-d @token.json https://api.github.com/authorizations`

**Note:** if you have two-factor authentication enabled, you will also need to 
include your 2FA code with the following:

`--header "x-github-otp: YOUR_CODE_HERE"`

After using the `curl` command above, you will be prompted for your account 
password. If successful you will receive a response like this:

```json
{
  "id": 1,
  "url": "https://api.github.com/authorizations/1",
  "scopes": [
    "public_repo"
  ],
  "token": "abcdefgh12345678",
  "token_last_eight": "12345678",
  "hashed_token": "25f94a2a5c7fbaf499c665bc73d67c1c87e496da8985131633ee0a95819db2e8",
  "app": {
    "url": "http://my-github-app.com",
    "name": "my github app",
    "client_id": "abcde12345fghij67890"
  },
  "note": "optional note",
  "note_url": "http://optional/note/url",
  "updated_at": "2011-09-06T20:39:23Z",
  "created_at": "2011-09-06T17:26:27Z",
  "fingerprint": ""
}
```

**IMPORTANT: copy the `token` value immediately.** You will need this for the next 
section.

### Generate Kubernetes secret

You need to create a [Kubernetes secret](https://kubernetes.io/docs/concepts/configuration/secret/) 
with both your webhook secret and personal access token. It is preferable to 
generate this via the command line. I ran into issues when using a YAML file 
where somehow foreign characters were being passed in, thereby creating 
verification problems.

![](userinput.png)
>`$_> kubectl create secret generic github-access \`     
> `--from-literal=apiToken=YOUR_TOKEN_HERE \`     
> `--from-literal=webHookSecret=YOUR_SECRET_HERE -n argo-events`

### Gateway

- Create a new yaml file (`github-gateway.yaml`).

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Gateway
metadata:
  name: github-gateway
  labels:
    gateways.argoproj.io/gateway-controller-instanceid: argo-events
    argo-events-gateway-version: v0.10
spec:
  type: "github"
  # eventSource matches name of event source you will create next
  eventSource: "github-event-source"
  processorPort: "9330"
  eventProtocol:
    type: "HTTP"
    http:
      port: "9300"
  template:
    metadata:
      name: "github-gateway"
      labels:
        gateway-name: "github-gateway"
    spec:
      containers:
        - name: "gateway-client"
          image: "argoproj/gateway-client"
          imagePullPolicy: "Always"
          command: ["/bin/gateway-client"]
        - name: "github-events"
          image: "argoproj/github-gateway"
          imagePullPolicy: "Always"
          command: ["/bin/github-gateway"]
      serviceAccountName: "argo-events-sa"
  service:
    metadata:
      name: github-gateway-svc
    spec:
      selector:
        gateway-name: "github-gateway"
      ports:
        - port: 12000
          targetPort: 12000
      type: NodePort
  watchers:
    sensors:
      # each name should match the corresponding sensor you create later
      - name: "github-sensor"
```

![](userinput.png)
>`$_> kubectl apply -f github-gateway.yaml -n argo-events`

### Event Source

Inside `data.hook`, the service needs to be mapped to the Ingress that was set 
up earlier . It is preferred to name the `endpoint` based on the name of the 
repository you are connected to. Multiple subpaths can be defined under this 
endpoint.

Some important notes:

- `id` is the ID of the webhook you created
- `hook.port` needs to be the same as the gateway service
- `hook.url` is the URL the gateway uses to register at GitHub
- `apiToken` and `webHookSecret` both need their name and key from the K8s secret
- `insecure` is the type of connection between the gateway and GitHub
- `active` determines if notifications are sent when a webhook is triggered

This example will create two events.

- Create a new yaml file (`github-event-source.yaml`).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: github-event-source
  labels:
    argo-events-event-source-version: v0.10
data:
  dicty-stock-center: |-
    id: 123456
    owner: "dictybase"
    repository: "dicty-stock-center"
    hook:
     endpoint: "/github/dicty-stock-center"
     port: "12000"
     url: "https://ericargo.dictybase.dev"
    events:
    - "push"
    apiToken:
      name: github-access
      key: apiToken
    webHookSecret:
      name: github-access
      key: webHookSecret
    insecure: false
    active: true
    contentType: "json"
  dicty-frontpage: |-
    id: 123789
    owner: "dictybase"
    repository: "dicty-frontpage"
    hook:
     endpoint: "/github/dicty-frontpage"
     port: "12000"
     url: "https://ericargo.dictybase.dev"
    events:
    - "push"
    apiToken:
      name: github-access
      key: apiToken
    webHookSecret:
      name: github-access
      key: webHookSecret
    insecure: false
    active: true
    contentType: "json"
```

![](userinput.png)
>`$_> kubectl apply -f github-event-source.yaml -n argo-events`

### Sensor

The following example is very simple. We have set up a URL trigger that uses 
a [YAML config file](https://raw.githubusercontent.com/dictybase-playground/argo-test/master/config.yaml) 
which in turn points to a Docker container. An environmental variable is passed 
to the Dockerfile with the contents of our webhook JSON response. The only 
purpose of this Dockerfile is to print the JSON to the console, but it shows 
how this can be set up to later work with more complex use cases.

- Create a new yaml file (`github-sensor.yaml`).

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Sensor
metadata:
  name: github-sensor
  labels:
    sensors.argoproj.io/sensor-controller-instanceid: argo-events
    argo-events-sensor-version: v0.10
spec:
  template:
    spec:
      containers:
        - name: "sensor"
          image: "argoproj/sensor"
          imagePullPolicy: Always
      serviceAccountName: argo-events-sa
  dependencies:
    - name: "github-gateway:dicty-stock-center"
    - name: "github-gateway:dicty-frontpage"
  eventProtocol:
    type: "HTTP"
    http:
      port: "9300"
  triggers:
    - template:
        name: github-workflow-trigger
        group: argoproj.io
        version: v1alpha1
        kind: Workflow
        source:
          url:
            path: "https://raw.githubusercontent.com/dictybase-playground/argo-test/master/config.yaml"
            verifycert: false
      resourceParameters:
        - src:
            event: "github-gateway:dicty-stock-center"
          dest: spec.arguments.parameters.0.value
        - src:
            event: "github-gateway:dicty-frontpage"
          dest: spec.arguments.parameters.0.value
```

![](userinput.png)
>`$_> kubectl apply -f github-sensor.yaml -n argo-events`

Now you can test this out by creating issues, leaving comments, etc. inside of 
the GitHub repository you set up the webhook for.

#### Helpful Links

- [GitHub Webhook events documentation](https://developer.github.com/webhooks/)
- [GitHub Webhook Push event payload](https://developer.github.com/v3/activity/events/types/#pushevent)

## Minio Setup

This will show how to capture `POST` and `PUT` requests to a Minio bucket.

### Kubernetes Secret

This guide asssumes that your installation of Minio is in the `dictybase` namespace. 
You will need to copy over your `minio` secret from the `dictybase` namespace.

![](userinput.png)
>`$_> kubectl get secret minio -n dictybase --export -o yaml | \`     
> `kubectl apply -n argo-events -f -`

### Gateway

Here we will follow the official Argo Events example that uses `artifact`.

- Create a new yaml file (`artifact-gateway.yaml`).

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Gateway
metadata:
  name: artifact-gateway
  labels:
    gateways.argoproj.io/gateway-controller-instanceid: argo-events
    argo-events-gateway-version: v0.10
spec:
  processorPort: "9330"
  eventProtocol:
    type: "HTTP"
    http:
      port: "9300"
  template:
    metadata:
      name: "artifact-gateway"
      labels:
        gateway-name: "artifact-gateway"
    spec:
      containers:
        - name: "gateway-client"
          image: "argoproj/gateway-client"
          imagePullPolicy: "Always"
          command: ["/bin/gateway-client"]
        - name: "artifact-events"
          image: "argoproj/artifact-gateway"
          imagePullPolicy: "Always"
          command: ["/bin/artifact-gateway"]
      serviceAccountName: "argo-events-sa"
  eventSource: "artifact-event-source"
  eventVersion: "1.0"
  type: "artifact"
  watchers:
    sensors:
      - name: "artifact-sensor"
```

![](userinput.png)
>`$_> kubectl apply -f artifact-gateway.yaml -n argo-events`

### Event Source

`bucket.name` refers to the bucket you want to listen to events for. The `endpoint` 
is the cluster IP for the running Minio instance. In this example, we are connecting 
to `minio` service in the `dictybase` namespace on port `9000`. Writing out the port 
as `minio.dictybase` causes an error.

`events` is an array of the [bucket notifications](https://docs.min.io/docs/minio-bucket-notification-guide.html) 
to subscribe to.

`filter` can listen to specific types of files. Otherwise just pass empty strings.

`accessKey` and `secretKey` need to the location of the corresponding K8s secret.

- Create a new yaml file (`artifact-event-source.yaml`).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: artifact-event-source
  labels:
    argo-events-event-source-version: v0.10
data:
  minio-example: |-
    bucket:
      name: input
    endpoint: minio.dictybase:9000
    events:
     - s3:ObjectCreated:Put
     - s3:ObjectCreated:Post
    filter:
      prefix: ""
      suffix: ""
    insecure: true
    accessKey:
      key: accesskey
      name: minio
    secretKey:
      key: secretkey
      name: minio
```

![](userinput.png)
>`$_> kubectl apply -f artifact-event-source.yaml -n argo-events`

### Sensor

- Create a new yaml file (`artifact-sensor.yaml`).

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Sensor
metadata:
  name: artifact-sensor
  labels:
    sensors.argoproj.io/sensor-controller-instanceid: argo-events
    argo-events-sensor-version: v0.10
spec:
  template:
    spec:
      containers:
        - name: "sensor"
          image: "argoproj/sensor"
          imagePullPolicy: Always
      serviceAccountName: argo-events-sa
  dependencies:
    - name: "artifact-gateway:minio-example"
  eventProtocol:
    type: "HTTP"
    http:
      port: "9300"
  triggers:
    - template:
        name: github-workflow-trigger
        group: argoproj.io
        version: v1alpha1
        kind: Workflow
        source:
          url:
            path: YAML_FILE_HERE...
            verifycert: false
      resourceParameters:
        - src:
            event: "artifact-gateway:minio-example"
          dest: spec.arguments.parameters.0.value
```

![](userinput.png)
>`$_> kubectl apply -f artifact-sensor.yaml -n argo-events`

#### Helpful Links

[Event Message Structure](https://docs.aws.amazon.com/AmazonS3/latest/dev/notification-content-structure.html)