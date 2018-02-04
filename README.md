# Entry point for overhaul project
## Conventions
+ The project should link to mostly work in progress documentation, finished one is also acceptable.
+ The link could be internal markdown or external.
+ Create subproject links if neccessary, however choose a name close to a one mentioned in __overhaul__ document.
+ Create an issue in any of the dictyBase github repositories for tracking the
  progress. Link it out from from its documentation project here.

## Projects
* [Database versioning](/DB-versioning.md)
* [Unit testing](/Unit-testing.md)
* Data export from oracle
    * [Gene models/annotations](Gene-models-export.md)
    * [Literature/annotations](Literature-annotations.md)
    * [Stock/Phenotype](Stock-Export.md)
* Data Import in Postgresql
    * [Gene models/annotations](Gene-models-import.md)
    * [GPAD](GPAD-Import.md)
    * [Ontologies](Ontology-import.md)
    * [Literature](Literature-import.md)
    * [Stock/Phenotype](Stock-Import.md) 
    * Support for data with non-ascii characters in postgresql.
* [Importing](Import-analysis.md) data from analysis.
* Backend data access
    * [Specification](Webservice-specs.md)
    * [Microservices API and specifications](https://dictybase.github.io/dictybase-api/)
    * Software implementation
        * [User](https://github.com/dictyBase/modware-user)
        * [Content](https://github.com/dictyBase/modware-content)
* Frontend Web UI
    * [dictyBase front page](https://github.com/dictyBase/dicty-frontpage).
    * [Gene page](https://github.com/dictyBase/genomepage://github.com/dictyBase/genomepage/)
    * Literature and ontology.
    * [Stock center and ordering](https://github.com/dictyBase/Dicty-Stock-Center/).
    * [Blast](https://github.com/dictyBase/dicty-components-blast/).
    * Search.
    * [Curation tools mockup](curation-tools/mockup ) 
* Batch processing
* Misc
* Third party tools
* [Deploy](deploy.md)

## Data dependencies and current migration status

![data_dependency](https://cloud.githubusercontent.com/assets/48740/6073492/b3ac845e-ad74-11e4-9a2e-268ba0fdea6e.png)


#### Colors
* Green: Completed
* Red: Incomplete
* Gradient: Partially complete

 
# Oracle database refresh
The instuctions for database refresh is [here](Oracle-database-sync.md)

# Archived(Retired, only here for information)
* [Server setup and deployment](Server-setup.md)
* [Hosting](Hosting.md)
