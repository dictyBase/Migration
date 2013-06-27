# Database versioning for Chado @dictyBase.org

## Getting Started
### Installation & Setup

* [Setup `Perl` environment using `perlbrew`](http://dictybase.github.io/perl-setup/index.html) or `plenv`
* Run the following to install required modules

```perl
cpanm App::Sqitch DBD::Pg
cpanm git@github.com:dictyBase/App-Sqitch-data.git@develop
```
_* Note: If using `plenv`, do not foregt to `plenv rehash`_

* Create a new project

```shell
createdb <db-name>
sqitch --engine pg --db-name <db-name> init <project-name> 
```
This should create a few files and folders in the current directory, and it should look like
<img src="https://www.dropbox.com/s/pcy67t7vazl0hlt/sqitch_project_ls.png" />

_* Note: You might want to increase `max_locks_per_transaction` for PostgreSQL, You can find that configuration in `postgresql.conf` under your PostgreSQL data directory._

## [Chado](http://gmod.org/wiki/Chado_Tables)

We are starting with Chado version 1.2. This is help us keep Chado under version control going forward.

The SQL for schema and changes can be obtained from [here](http://gmod.org/wiki/Chado_-_Getting_Started#Installation)

1. To add changes related to Chado-1.2

```shell
sqitch add chado_1.2 -n 'Chado 1.2'
```
	* This will create 3 files, `deploy/chado_1.2.sql`, `revert/chado-1.2.sql` & `verify/chado-1.2.sql`
	* Update `deploy/chado-1.2.sql` with `1.2/default_schema.sql`. Write `DROP TABLE/SCHEMA` statements in `revert/chado-1.2.sql`.


