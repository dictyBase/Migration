## Database versioning

### [Alembic]

#### References

1. [readthedocs](http://alembic.readthedocs.org/en/latest/index.html) 
2. [Data migration with schema - Alembic mailing list](https://groups.google.com/forum/?fromgroups=#!topic/sqlalchemy-alembic/gCJO4W0GKB4)
3. [`alembic` operations](https://alembic.readthedocs.org/en/latest/ops.html) 

#### Tasks

1. Simple migrations with SQLite/PostgreSQL
	* Tables with Foreign keys
	* Table columns with default values
	* Unique key constraints on fields
	* Alter datatypes of columns in tables
2. Handling data with schema migrations
	* SQL data dump by the same ID as schema migration
	*


#### Getting started with 

To install, setup a sandboxed python environment using pythonbrew or pyenv and install alembic
```python
pip install alembic
```

#### Observations
* To set a default value for a column (`sa.Column`) - `server_default=sa.sql.expression.text('false') # example for sa.Boolean`
* `alter_column` not working with `sqlite3` 

#### Ideas
* It is important for us to manage data along with the schema changes. So, it is worth considering to link data dumps with each migration/change on schema

_TODO_: More details, with example

__Community discussions__

1. [Thread on Stackoverflow](http://stackoverflow.com/questions/16066720/database-versioning-and-migration-techniques-for-schema-data)
