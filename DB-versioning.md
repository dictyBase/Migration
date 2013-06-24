# Database versioning

## Tasks

* _This is work in progress. This section will keep changing_

1. Simple migrations with SQLite/PostgreSQL ~ (1 day | 06/05-06/06)
	* ~~Tables with Foreign keys~~
	* ~~Table columns with default values~~
	* ~~Unique key constraints on fields~~
	* ~~Alter datatypes of columns in tables~~
2. Handling data with schema migrations (experimentation) - __Expected functionality__ (~ 3 days)
	* SQL data dump by the same ID as schema migration
	* Add subcommand to the tool to load and dump data using the current schema version (later) (06/10)
		* Add `dump_data` and `load_data` commands. These command should use the tool API to pick up the version of schema (~ 1 day)
			1. ~~Ask in mailing list about custom namespace~~
			2. ~~Fix POD issue~~
			3. Unit test for subcommand. Look App::Sqitch test
		* For `Sqitch`, extend `App::Sqitch::Command` with your custom command. (~ 1 day)
			1. ~~Get `status` id.~~
			2. ~~Data dump/load for each `status` id to filesystem~~
			3. ~~Handling data dump/load~~
		* ~~For `Alembic`, yet to try out how it works and how it can be extended (~ 2 days)~~ (NOT required)
3. Manipulating how tools save schema versions (experimentation/discussion) ~ (6 days) (06/21)
	* Customize what tables/schema is used for storing migration information.
	* `Sqitch` usese a complete schema with 5 tables. See if it can be broken down.
	* How well can these changes go with `chadoprops`?
4. User & code documentation

* Estimated finish June 28st, 2013

---

## Requirements

1. Understand how Chado does schema versioning. Chado has a table named `chadoprops` 
	* Figure out how each of the tools handle schema versions.
		1. ~~Alembic has a table named `alembic_version`~~
		2. For `PostgreSQL`, `sqitch` creates a `schema` called `sqitch` which has 5 tables 
2. Being able to use SQL statements for modifications. Less dependence on external tools. 

---

## Background
1. Chado schema
	* Schema is stable. 
	* Does not have default versioning system
2. We will have to make changes to default schema. It should be possible for us to make changes upstream
	* e.g - If we make changes on default schema today, and the schema changes tomorrow; we should be able to keep track of all changes
3. __We are NOT doing data versioning, ONLY schema versioning__

---

## What to expect from a tool?

1. Less or NO dependence on ORMs or other external tools.
2. Use of plain SQL statements for managing changes
3. Being able to customize how the schema versions are stored  
4. Ability to tag data dump with with each schema migration
5. Better documentation, live development, active community

---

## Evaluation

### Inference

1. `Alembic`
	* _Advantage_
		1. Migrations can be written in SQL and also using sugar-coated interface 
		2. Start and end defined by `base` and `head`. Easy movement between the two using +/-
	* _Disadvantage_
		1. Depends on `SQLAlchemy` (ORM in `Python`)
2. `App::Sqitch`
	* _Advantage_
		1. All migrations are written in pure SQL
		2. One migration can have other (previous) migration as a dependency. So a new migration will always deploy its dependency before it runs. 
		3. Create `git` like tag for your set of migrations.
		4. NO ORM dependency
		5. Ability to set global config `~/.sqitch/sqitch.conf`. Project specific customizations can be made in the project folder using `sqitch.conf`
	* _Disadvantage_
		1. Revert and deploy happens from the @HEAD. Unlike alembic, there is no `base`, but only `head` 

### Observations
* To set a default value for a column (`sa.Column`)

```python
server_default=sa.sql.expression.text('false') # example for sa.Boolean
```
* `alter_column` not supported for `sqlite3` 

--- 

## Reference

1. Alembic
	1. [readthedocs](http://alembic.readthedocs.org/en/latest/index.html) 
	2. [Data migration with schema - Alembic mailing list](https://groups.google.com/forum/?fromgroups=#!topic/sqlalchemy-alembic/gCJO4W0GKB4)
	3. [`alembic` operations](https://alembic.readthedocs.org/en/latest/ops.html) 
2. App::Sqitch
	1. [sqitch.org](http://sqitch.org/)
	2. Tutorials - [PostgreSQL](https://metacpan.org/module/sqitchtutorial), [SQLite](https://metacpan.org/module/sqitchtutorial-sqlite) 
	3. [MetaCPAN](https://metacpan.org/module/DWHEELER/App-Sqitch-0.972/lib/App/Sqitch.pm)

---

#### Getting started with 

To install, setup a sandboxed python environment using `pythonbrew` or `pyenv` and install alembic

```python
pip install alembic
```

#### Ideas
* It is important for us to manage data along with the schema changes. So, it is worth considering to link data dumps with each migration/change on schema

_TODO_: More details, with example

__Community discussions__

1. [Thread on Stackoverflow](http://stackoverflow.com/questions/16066720/database-versioning-and-migration-techniques-for-schema-data)


* _Views, opinions, observations are personal and has nothing to do with anybody_
