## Database versioning

__Community discussions__
1. [Thread on Stackoverflow](http://stackoverflow.com/questions/16066720/database-versioning-and-migration-techniques-for-schema-data)
2. [Alembic mailing list](https://groups.google.com/forum/?fromgroups=#!topic/sqlalchemy-alembic/gCJO4W0GKB4)

### Getting started with [Alembic](http://alembic.readthedocs.org/en/latest/index.html)

To install, setup a sandboxed python environment using pythonbrew or pyenv and install alembic
```python
pip install alembic
```

### Ideas
* It is important for us to manage data along with the schema changes. So, it is worth considering to link data dumps with each migration/change on schema

_TODO_: More details, with example
