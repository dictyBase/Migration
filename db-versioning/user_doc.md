# Database versioning for Chado @dictyBase.org

## Setup

* [Setup `Perl` environment using `perlbrew`](http://dictybase.github.io/perl-setup/index.html) or `plenv`
* Run the following to install required modules

```perl
cpanm App::Sqitch DBD::Pg
cpanm git@github.com:dictyBase/App-Sqitch-data.git@develop
```
_* Note: If using `plenv`, do not foregt to `plenv rehash`_

## Getting Started

* Create a new project

```zsh
createdb <db-name>
sqitch --engine pg --db-name <db-name> init <project-name> 
```
This should create a few files and folders in the current directory, and it should look like
![`ls` in sqitch root directory](https://www.dropbox.com/s/pcy67t7vazl0hlt/sqitch_project_ls.png)

_* Note: You might want to increase `max_locks_per_transaction` for PostgreSQL, You can find that configuration in `postgresql.conf` under your PostgreSQL data directory._
