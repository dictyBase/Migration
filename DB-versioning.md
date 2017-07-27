# Database versioning
[Sqitch](https://metacpan.org/release/App-Sqitcha) tool is used for versioning.
The database schema is in
[chado-sqitch](https://github.com/dictyBase/Chado-Sqitch/tree/dictychado) along
with its [documentation](http://dictybase.github.io/Chado-Sqitch/).  
To modify the schema, follow the following steps, you do need to have [docker](https://docker.io) installed.

+ Clone `chado-sqitch` repo and switch to `dictychado` branch.  
```
git clone https://github.com/dictyBase/Chado-Sqitch.git
git checkout -b dictychado origin/dictychado
```
+ Mount the repository inside the docker container.  
```
docker run --rm -it -v ${PWD}:/usr/src/chado-sqitch dictybase/chado-sqitch-devel /bin/bash

```
+ Add sqitch configurations.  
```
sqitch config --user user.name "user name"
sqitch config --user user.email "user email"
sqitch config --user core.pg.client `which psql`
```
+ Add database configurations where the schema will be deployed.  
```
sqitch target add chadotarget db:pg://chadopass:chadouser@chadohost:chadoport/chadodb
sqitch config core.pg.target chadotarget
```
+ Add new changes to the schema
```
sqitch add chadochange --requires somethingsomething -n "some change"
```
Then edit the files in `deploy`,`revert` and `verify` folders.

+ Commit the files in git
```
git add deploy revert verify
git commit -m "some changes added"
```
+ Add the sqitch tag and commit the plan file
```
sqitch tag 1.3.5 -n "Tag 1.3.5"
git add sqitch.plan
git commit -m "updated the plan file with Tag 1.3.5"
```
+ Create a bundle, make a tarball and push code to github
```
sqitch bundle --dest-dir chado-1.3.5
tar cvzf chado-1.3.5.tar.gz chado-1.3.5
git push origin dictychado
```
+ Create a new release from github release page and upload the tarball for that release  
+ Clone [chado-sqitch docker](https://github.com/dictybase-docker/chado-sqitch)
  repository and update the `Dockerfile` with appropriate release name. Create
  a git tag and push both master and tag which will create new docker image in
  `docker hub`.

  > [Previous discussion](DB-versioning/README.md)
