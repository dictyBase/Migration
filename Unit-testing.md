Project [page](https://github.com/dictyBase/Test-Chado)


# Done

## Sqlite backend
* Database and schema manager(CRUD)
* Fixutre manager
* Working test api.

## Postgresql backend
* Testing through arbitary dsn.
  * Database and schema manager(CRUD)
  * Fixutre manager
  * Working test api.
* Postgresion support
  * Database and schema manager(CRUD)
* Test::Postgresql support
  * Database and schema manager(CRUD)
  * Fixutre manager

## API for Test::Chado module
* chado_schema
* drop_schema
* reload_schema

## API for Test::Chado::Common module

This has been split to a separate module and all of them needs a schema argument.

* has_cv
* has_dbxref
* has_cvterm
* has_feature
* has_featureloc


## Support for DBIC-Fixtures

+ The default should be to load bundled [DBIC-Fixtures](https://metacpan.org/module/DBIx::Class::Fixtures). 
+ The fallback should be the flat files.

## Maintenance scripts
+ Update ```DBIC-Fixtures``` bundle. 


#Working

## Documentation 
* User docuemantion. (~ 2 days)
* API documentation. (~ 1 day)

## Postgresql 
* Support for schema namespace. __~ day and half__

## Loading custom fixtures
+ Preset ```DBIC-Fixtures``` __~ 1 day__
+ Loading from flat files. __~ 1 day__

## Maintenance scripts
+ Update chado schema for various backends. __~ 1 day__
+ Update flat files. __~ 1 day__


#Defered

## API for Test::Chado::Common module

* has_reference_feature
* has_children_feature
* has_parent_feature


## Support for custom schema 

## Additional API
It should be split into separate modules. For example, ```Test::Chado::Sequence``` should have additional __API__ for testing features,
```Test::Chado::Pub``` for publications, ```Test::Chado::Cvterm``` for cvterm and its associations etc. 

* Test::Chado::Sequence
* Test::Chado::Cvterm
* Test::Chado::Pub
* Test::Chado::Stock


