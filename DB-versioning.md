# Database versioning

## Requirements

1. Understand how Chado does schema versioning. Chado has a table named `chadoprops` 
	* Figure out how each of the tools handle schema versions.
		1. Alembic has a table named `alembic_version`
		2. For `PostgreSQL`, `sqitch` creates a `schema` called `sqitch` which has 5 tables 
2. Being able to use SQL statements for modifications. Less dependence on external tools. 

---

## What to expect from a tool?


---

## Evaluation
### Background
1. Chado schema
	* Schema is stable. 
	* Does not have default versioning system
2. We will have to make changes to default schema. It should be possible for us to make changes upstream
	* e.g - If we make changes on default schema today, and the schema changes tomorrow; we should be able to keep track of all changes
3. __We are NOT doing data versioning, ONLY schema versioning__

### Ranking

One evaluating, `alembic` amd `sqitch`;

Feature | `Alembic` | `App::Sqitch`
--- | --- | ---
Documentation | 8 | 6 
Usability | | 
Default values & Foriegn keys | |
Constraints | |
Alter datatypes | | 
Versioning ID | |

Scoring based on following tasks:

1. Simple migrations with SQLite/PostgreSQL
	* ~~Tables with Foreign keys~~
	* ~~Table columns with default values~~
	* ~~Unique key constraints on fields~~
	* ~~Alter datatypes of columns in tables~~
2. Handling data with schema migrations
	* SQL data dump by the same ID as schema migration

### Inference

1. `Alembic`
	* _Advantage_
		1. _TODO_
		2. _TODO_
	* _Disadvantage_
		1. _TODO_
		2. _TODO_
2. `App::Sqitch`
	* _Advantage_
		1. _TODO_
		2. _TODO_
	* _Disadvantage_
		1. _TODO_
		2. _TODO_

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
	2. Tutorials - [PostgreSQL](), [SQLite]() 
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


