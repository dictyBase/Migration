# Design and Specs
It's given in this [presentation](http://testgenomes.dictybase.org/server.slide#1). A copy
of the server specs is also kept [here](Server-specs.md).


# Strategy
* The default strategy is to use [docker](http://docker.io) container to deploy
  every applications. The applications could span across multiple hosts. 
* The applications will use service discovery for communication.
  [Consul](http://consul.io) will be used for service discovery. Communication
  between server could be
  [encrypted](http://www.consul.io/docs/agent/encryption.html) for inter server
  consul cluster.

# Container practices for orchestration
* There will be primarilly two types of containers, data and application. The
  data containers will provide docker volumes to share data. The application
  will only run the application and will be build using data containers for
  sharing or accessing data.
* The data containers should provide the following standard volumes for
  managing data ...
 * __/config__: For managing configuration files.
 * __/data__: For any kind of data.
 * __/secret__: For having any kind of credentials.
 * __/log__: For managing logs.
  The ideas are inspired from [here](https://github.com/radial/docss://github.com/radial/docs)
* The data containers will be built from a ```busybox``` image, the one
  [here](https://registry.hub.docker.com/u/progrium/busybox://registry.hub.docker.com/u/progrium/busybox/)
  seems to be suitable.
* For the first round, the application containers will try to use a standard
  language
  [stacks](https://blog.docker.com/2014/09/docker-hub-official-repos-announcing-language-stacks/)
  or use a standard ubuntu/centos/debian. To reduce the image size, port them
  to alpine [image](https://registry.hub.docker.com/u/library/alpine/) later on.
* All of our reusable images would be stored in
  [dictybase](https://registry.hub.docker.com/repos/dictybase/) repository in
  docker hub.


# Server setup
The following softwares should be present in every server.

* [docker](docker.io) should be installed in every host. The HTTP interface
  should be [secured](https://docs.docker.com/articles/https/) by TLS. For
  production, we need to buy a ssl certificate for dictybase.
* Install [registrator](https://github.com/progrium/registrator) and container.
  It will register/deregister services for every container that run/stop in the
  host. The [consul](http://consul.io) will be used for service backend. The
  alternative is to use
  [docker-plugin](https://github.com/progrium/docker-plugins) for example a
  [plugin](https://github.com/bryanlarsen/docker-plugin-kv-consul) to store
  key-value on consul.
* Use [ansible](http://www.ansible.com/home) playbook for deploying. However, if deploying
  through https works, then ansible could be limited only for basic hosts setup. And even,
  every hosts could come setup with docker and dependent softwares then ansible could be
  used sparingly.


# Application deployment
* Every piece of code that runs of remote server should be treated as an
  application. There will be almost no server side code editing or running any
  adhoc applications.
* Every application should have a complement source code git repository for
  deploying through docker. Those repositories should reside under
  [dictybase-docker](https://github.com/dictybase-docker) organization.  The
  application is expected to have a stack of containers which will be
  orchestrated and deployed by
  [docker-compose](http://docs.docker.com/compose/).  Example:
  https://github.com/dictybase-docker/frontpage
* Deploy to remote server through docker API over HTTPS.
* It is recommended to use service discovery(consul) to provide configuration
  variables for application. However, instead of changing the application code,
  write a wrapper shell script to pull the data from service backend and then
  fed it to the application. Use [jq](http://stedolan.github.io/jq/) to parse
  ```JSON``` data in shell script.  
  To put data, the container could use env
  variables and a docker-plugin could save them them in the service backend.
  For consistency, the shared env vars could use a common namespace.
  
# Under exploration(Yet to decide)
## Database server
* A custom made postgresql database container will be used. The data folder
  will be managed using [container
  pattern](https://docs.docker.com/userguide/dockervolumes/). 
* The database container will be created from
  [this](https://github.com/dictybase-docker/docs/tree/master/postgres)
  repository.
* __Backup__:Other than standard backup a file level backup will be done using container
  level
  [backup](https://docs.docker.com/userguide/dockervolumes/#backup-restore-or-migrate-data-volumes).
* __Upgrade__: The simple minded upgraded would be to stop the running
  container, start a new one with new version by pointing it the data volume.
  However, other options still needs to be explored.

## Misc
* Managing dependent containers. If one container goes down or gets restarted,
  the dependent should also follow.
* Health check using consul. The default should be fine, however have to decide
  on a consistent strategy.
