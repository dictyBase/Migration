# Strategy
* The default strategy is to use [docker](http://docker.io) container to deploy
  every applications. The applications could span across multiple hosts. 
* The applications will use service discovery for communication.
  [Consul](http://consul.io) will be used for service discovery. Communication
  between server could be
  [encrypted](http://www.consul.io/docs/agent/encryption.html) for inter server
  consul cluster.

# Server setup
The following softwares should be present in every server.

* [docker](docker.io) should be installed in every host. The HTTP interface by default should be disabled.
* Install [registrator](https://github.com/progrium/registrator) and
  [fleetstreet](https://github.com/binocarlos/fleetstreet) containers. They
  will register/deregister services for every container that run/stop in the
  host. The [consul](http://consul.io) will be used for service backend.
* Install and setup [sshcommand](https://github.com/progrium/sshcommand) and
  [gitreceive](https://github.com/progrium/gitreceive)
* [sshcommand](https://github.com/progrium/sshcommand) could be installed using
  an [ansible](http://www.ansible.com/home) playbook. The rest of them could be
  installed then installed using sshcommand or entirely by ansible as
  neccessary.

## Yet to decide
* Health check using consul. The default should be fine, however have to decide
  on a consistent strategy.
* Managing dependent containers. If one container goes down or gets restarted,
  the dependent should also follow.
* Maintaining a private [docker registry](https://github.com/docker/docker-registry).

# Application deployment
* Every piece of code that runs of remote server should be treated as an
  application. There will be almost no server side code editing or running any
  adhoc applications.
* Every application should reside in a git repository, should have a defined
  ```Dockerfile``` to package the application.  The will be a ```fig.yaml```
  file to build and run the container using
  [fig](http://www.fig.sh/index.html). Here is an
  [setup](http://blog.docker.com/2014/08/orchestrating-docker-containers-in-production-using-fig/).
* The application will be pushed via git over ssh to server.
  [Gitreceive](https://github.com/progrium/gitreceive) will trigger
  post-receive script in the server and use server side
  [fig](http://www.fig.sh/index.html) installation to run the container.
* It is recommended to use service discovery(consul) to provide configuration
  variables for application. However, instead of changing the application code,
  write a wrapper shell script to pull of the data from service backend and
  then fed it to the application. Use [jq](http://stedolan.github.io/jq/) to
  parse ```JSON``` data in shell script.

# Database server
* A custom made postgresql database container will be used. The data folder
  will be managed using [container
  pattern](https://docs.docker.com/userguide/dockervolumes/). 
* Other than standard backup a file level backup will be done using container
  level
  [backup](https://docs.docker.com/userguide/dockervolumes/#backup-restore-or-migrate-data-volumes).
* The database container should be a modified version of [flynn
  container.](https://github.com/flynn/flynn/tree/master/appliance/postgresql).
  It should provide a restricted ```HTTP API``` to create user and database.
  Other than the default service registration, there will some baked in code to
  register database credentials with service backend.
