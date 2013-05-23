A place for draft ideas, mostly yet to be implemented or being worked on.

__Project:__ Work in [progress](https://github.com/dictyBase/Test-Chado)

## Backend support

* Sqlite. __Done__
* Postgresql. __Ongoing__

## API for Test::Chado module
__Done mostly, rest of done will be added as we go along__.

+ chado_schema

    should load chado schema.

    should have SQLite backend as default.

    should accept optional ```--dsn```,```--user```,```--pass``` parameters.

    should return appropiate backend based on above arguments.

    should return a __Bio::Chado::Schema__ object.

    should be a singleton. 
        For testing context, it should be one instance per ```.t``` file.

    should croak if a appropiate backend is unavailable.
    
    should accept ```--base-fixture``` parameter with boolean argument. 

     The default should be false, however if set should load the basic fixtures.

+ drop_schema

+ reload_schema

    should drop and reloads the schema.

    should accept ```--base-fixture``` parameter, similar to chado_schema.

+ has_cv

    should check for a cv present in underlying chado database.

+ has_dbxref

    should check for a dbxref entry
+ has_cvterm

+ has_feature

+ has_featureloc

    ```has_feature``` is implied

+ has_reference_feature

    should check if a feature has a srcfeature_id in featureloc table

    ```has_featureloc``` is implied

+ has_children_feature

    ```has_feature``` is implied

    ```part_of``` is the default relation

+ has_parent_feature

    ```has_feature``` is implied

    ```part_of``` is the default relation

## Additional API
__Will be developed as we go along with other project__

It should be split into separate modules. For example, ```Test::Chado::Sequence``` should have additional __API__ for testing features,
```Test::Chado::Pub``` for publications, ```Test::Chado::Cvterm``` for cvterm and its associations etc. For the time being, following optional modules are
under consideration..

* Test::Chado::Sequence
* Test::Chado::Cvterm
* Test::Chado::Pub
* Test::Chado::Stock

## Support for DBIC-Fixtures
+ The default should be to load bundled [DBIC-Fixtures](https://metacpan.org/module/DBIx::Class::Fixtures). 
+ The fallback should be the flat files.

__Done for Sqlite__


## Loading custom fixtures
__Will be developed as we go along with other project__

+ Should support both pre-made ```DBIC-Fixtures``` and loading from flat files.

## Support for custom schema

__Probably if needed later on__.

## Maintenance scripts
+ Update chado schema for various backends.
+ Update flat files.
+ Update ```DBIC-Fixtures``` bundle. __Done__

## Documentation

__Ongoing__

* User docuemantion.
* API documentation.

