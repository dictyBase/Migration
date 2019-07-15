# Suggested Order

1) Helm
    - create rbac
    - initialize w/ tiller
    - add dictybase helm repo
2) [Create clusterrolebindings](admin.md)
    - admin
    - nats
3) [Create custom storage class using SSD](storageclass.md)
4) [Install Ingress](ingress.md)
    - install nginx-controller
    - install cert-manager
    - create issuer
    - create certificate
    - install dictybase-auth-ingress
    - install dictybase-ingress
5) [Install Minio](minio.md)
6) [Install ArangoDB](arangodb.md)
    - install kube-arangodb-crd
    - install kube-arangodb
    - install dictybase/arangodb
    - install dictybase/arango-create-database
7) Install Nats
    - nats-operator
    - nats
8) [Install Argo](argoevents.md)
    - create argo namespace
    - add argo helm repo
    - create issuer
    - create certificate
    - create minio secret
    - apply argo workflow rbac
    - install argo w/ custom values
    - install argo-events (same namespace)
    - create github gateway ingress
    - create github secret
    - create slack secret
    - create docker secret
    - install argo-pipeline
8) Install PostgreSQL
    - install dictycontent-schema
    - install dictyuser-schema
9) Install Redis
10) Install API services
    - content-api-server
    - user-api-server
    - identity-api-server
    - authserver
    - modware-order
    - modware-stock
    - modware-annotation
11) Install graphql-server
12) Load data
    - load-users
    - content-loader
    - assign-roles-permissions
    - load-identity
13) Install kubeless
    - genefn
    - genecachefn
    - uniprotcachefn
    - goidsfn
    - dashfn
    - pubfn
14) Install frontend web apps
    - dicty-stock-center
    - dicty-frontpage
    - genomepage
    - dictyaccess
    - publication

---

# Deployments with prereqs

## Argo
- cert-manager
- cluster admin
- minio
- minio secret
- workflow rbac
- custom config (serviceaccount, namespace, ingress, minio) on install

## Argo Events
- argo

## Argo Pipeline
- argo
- argo events
- slack secret
- github secret
- docker secret
- github ingress

## ArangoDB
- nats

## API Services...

## Content API
- postgreSQL
- dictycontent schema

## User API
- postgreSQL
- dictyuser schema

## Identity API
- arangodb

## Order API
- arangodb

## Stock API
- arangodb

## Annotation API
- arangodb

## GraphQL Server
- content
- user
- order
- stock
- annotation
- kubeless
    - pubfn


## Frontend apps...

## DSC
- authserver
- content api
- user api
- identity api
- order api
- stock api
- annotation api
- graphql server

## dicty-frontpage
- authserver
- content api
- user api
- identity api

## genomepage
- authserver
- user api
- identity api
- kubeless
    - genefn
    - genecachefn
    - uniprotcachefn
    - goidsfn

## dictyaccess
- authserver
- user api
- identity api
- kubeless
    - dashfn

## publication
- authserver
- user api
- identity api
- graphql server