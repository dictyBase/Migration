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
* Support for schema namespace. 

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


## Documentation 

* User docuemantion.
* API documentation.


## Support for DBIC-Fixtures

+ The default should be to load bundled [DBIC-Fixtures](https://metacpan.org/module/DBIx::Class::Fixtures). 
+ The fallback should be the flat files.

## Maintenance scripts
+ Update ```DBIC-Fixtures``` bundle. 


#Working

#Defered

## Loading custom fixtures
+ Preset ```DBIC-Fixtures``` __~ 3 days__
+ Loading from flat files. __~ 2 days__

## Maintenance scripts
+ Update chado schema for various backends. __~ 1 day__
+ Update flat files. __~ 1 day__

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

## Misc
Look in the gihub issue [tracker](https://github.com/dictyBase/Test-Chado/issues?state=open)
