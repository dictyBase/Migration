# Argo Events

Here we will go through the process of setting up Argo Events with a GitHub 
webhook in your cluster.

## Prerequisites
* Have a `configured (kubectl access)`
  [GKE](https://cloud.google.com/kubernetes-engine/) access.
* [Setup](admin.md) cluster admin access.

### Install Helm Charts

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
> `$_> helm install argo/argo --namespace argo`

- Install `argo-events` chart

![](userinput.png)
> `$_> helm install argo/argo-events --namespace argo-events`

#### Create cluster role for Argo Events service account

The `argo` Helm chart installs everything needed; however, its service account 
needs to have additional permissions. Run the following to do so:

>`$_>  kubectl create clusterrolebinding argo-events \ `    
>         `--clusterrole=cluster-admin \ `   
>         `--serviceaccount=argo-events:default`

### Generate Issuer and Certificate

You will need to create a new issuer and certificate -- these are required in 
order to set up Ingress (our next step). Make sure you have `cert-manager` set 
up per [these instructions](./certificate.md).

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

![](userinput.png)
>`$_> kubectl apply -f ingress-gh.yaml -n argo-events`

### Enable GitHub Webhooks

There are two ways to create a personal access token -- either through the command 
line or on GitHub. This guide will use the command line to create a webhook.

First, create a secret key. This can be anything you want, and it is important 
to keep track of this since it will be needed when creating an event source.

A helpful way to generate a secret key is by using the following command in the 
terminal:

`ruby -rsecurerandom -e 'puts SecureRandom.hex(20)'`

**Important:** Make note of this secret key -- you will need it shortly.

Create a JSON file with the desired configuration for the webhook. The URL value 
should be the webhook endpoint you will use later when creating an event source. 
Our standard format is to use `/github/:repo-name`.

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
>`$_> curl -X POST -H "Content-Type: application/json" -u YOUR_USERNAME_HERE `
>         `-d @payload.json https://api.github.com/repos/:owner/:repo/hooks`

**Note:** if you have [two-factor authentication](https://help.github.com/en/articles/securing-your-account-with-two-factor-authentication-2fa) 
enabled, you will also need to include your 2FA code with `--header "x-github-otp: YOUR_CODE_HERE"`

You will be prompted for your account password, then if successful you will 
receive a response like this:

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

There are two ways to create a personal access token -- either through the command 
line or on [GitHub](https://github.com/settings/tokens). In this guide, we will 
use the command line.

Create a JSON file with, at minimum, the `scopes` and `note` for this token. See 
[here](https://developer.github.com/v3/oauth_authorizations/#create-a-new-authorization) 
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
>`$_> curl -X POST -H "Content-Type: application/json" -u YOUR_USERNAME_HERE `
>         `-d @token.json https://api.github.com/authorizations`

**Note:** if you have two-factor authentication enabled, you will also need to 
include your 2FA code with `--header "x-github-otp: YOUR_CODE_HERE"`

You will be prompted for your account password, then you will receive a response 
like this:

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
>`$_> kubectl create secret generic github-access --from-literal=apiToken=YOUR_TOKEN_HERE `
>                        `--from-literal=webHookSecret=YOUR_SECRET_HERE -n argo-events`

## Argo Events Deployment Process

Three pieces are required for Argo Events and they need to be deployed in this 
exact order.

### Deploy the gateway

A gateway consumes events from event sources, transforms them into the 
[cloudevents specification](https://github.com/cloudevents/spec) compliant events 
and dispatches them to sensors.

One gateway can have multiple sensors, as denoted by the `watchers` key at the 
bottom of the config file. Because of this, one gateway can be used for multiple 
repositories.

The [official documentation](https://argoproj.github.io/argo-events/gateway/) has 
a diagram that shows the process from client to server.

- Create a new yaml file (`github-gateway.yaml`).

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Gateway
metadata:
  name: github-gateway
  labels:
    # gateway controller with instanceId "argo-events" will process this gateway
    gateways.argoproj.io/gateway-controller-instanceid: argo-events
    # gateway controller will use this label to match with its own version
    # do not remove
    argo-events-gateway-version: v0.10
spec:
  type: "github"
  eventSource: "github-event-source" # matches name of event source you will create next
  processorPort: "9330"
  eventProtocol:
    type: "HTTP"
    http:
      port: "9300" # same as processorPort
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
      type: NodePort # make sure not to use LoadBalancer
  watchers:
    sensors:
      - name: "github-sensor" # matches name of sensor you create after event-source
```

![](userinput.png)
>`$_> kubectl apply -f github-gateway.yaml -n argo-events`

### Deploy the event source

Event sources are config maps that are interpreted by the gateway as a source 
for events producing the entity.

In this file, you will need to specify the webhook ID, GitHub repository, the 
actual hook endpoint/port and the tokens from your K8s secret.

You can include multiple events in the same config file. In the below example, 
we have one event named `example`. You can easily add another by adding a new 
key under `data`, the same way that `example` is listed.

Inside `data.hook`, the service needs to be mapped to the Ingress that was set 
up earlier in this documentation. It is preferred to name the `endpoint` based 
on the name of the repository you are connected to. Multiple subpaths can be 
defined under this endpoint.

- Create a new yaml file (`github-event-source.yaml`).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: github-event-source
  labels:
    # do not remove
    argo-events-event-source-version: v0.10
data:
  example: |-
    # ID of the GitHub webhook
    # this needs to match the one you generated
    id: 123
    owner: "dictybase"
    repository: "test-repo"
    # Github will send events to the following port and endpoint
    hook:
     endpoint: "/github/test-repo"
     # Same as gateway service
     port: "12000"
     # url the gateway will use to register at GitHub
     url: "https://ericargo.dictybase.dev"
    # type of events to listen to
    events:
    - "*"
    # apiToken refers to K8s secret that stores the github personal access token
    apiToken:
      # Name of the K8s secret that contains the access token
      name: github-access
      # Corresponding key in the K8s secret
      key: apiToken
    # webHookSecret refers to K8s secret that stores the webhook secret
    webHookSecret:
      name: github-access
      key: webHookSecret
    # type of connection between gateway and github
    insecure: false
    # determines if notifications are sent when the webhook is triggered
    active: true
    contentType: "json"
```

![](userinput.png)
>`$_> kubectl apply -f github-event-source.yaml -n argo-events`

### Deploy the sensor

Sensors define a set of event dependencies (inputs) and triggers (outputs). 

An event dependency is the event the sensor is waiting for. It is defined as 
"gateway-name:event-source-name". Based on the config file we used for the event 
source, our dependency would be `github-gateway:example`.

Triggers are executed once the event dependencies are resolved.

Each sensor can have multiple events defined. The [documentation](https://argoproj.github.io/argo-events/sensor/) 
has a nice diagram showing the workflow.

The following example is very simple. We have set up a URL trigger that uses 
a [YAML config file](https://gist.githubusercontent.com/wildlifehexagon/6af9db7a0537b3e40962cb34adbb5edd/raw/63965625fecc821e5144e035bfe503ff57877910/gh-test.yaml) 
which in turn points to a Docker container. An environmental variable is passed 
to the Dockerfile with the contents of our webhook JSON response. The only 
purpose of this Dockerfile is to print the JSON to the console, but it shows 
how this can be set up with more complex use cases.

- Create a new yaml file (`github-sensor.yaml`).

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Sensor
metadata:
  name: github-sensor
  labels:
    # sensor controller with instanceId "argo-events" will process this sensor
    sensors.argoproj.io/sensor-controller-instanceid: argo-events
    # sensor controller will use this label to match with its own version
    # do not remove
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
    # name matching event sensor
    - name: "github-gateway:example"
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
            event: "github-gateway:example"
            # path: "action" # use this key if you only want certain values
          dest: spec.arguments.parameters.0.value
```

![](userinput.png)
>`$_> kubectl apply -f github-sensor.yaml -n argo-events`

Now you can test this out by creating issues, leaving comments, etc. inside of 
the GitHub repository you set up the webhook for.

#### Helpful links

- [GitHub Webhook events documentation](https://developer.github.com/webhooks/)
- [GitHub Webhook Push event payload](https://developer.github.com/v3/activity/events/types/#pushevent)
- [Argo Workflow documentation](https://github.com/argoproj/argo/blob/master/examples/README.md)
- [Argo Events documentation](https://argoproj.github.io/argo-events/)