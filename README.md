#Entry point for overhaul project
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
    * Specification
    * Software implementation
* Frontend Web UI
    * [Homepage/Header/Footer and static pages](Homepage-header-footer.md).
    * Gene page.
    * Literature and ontology.
    * Stock center/genotype/phenotype.
    * Blast.
    * Search.
* Batch processing
* Server setup
* [Software deployment](Deploy.md)
* Misc
* Third party tools
 
## Refreshing Oracle databases
The developer databases needs to be synced/refreshed occasionally for running
migration tasks on latest production database state. This step is to ensure the
reproducibility of migration softwares. Since the data models in Oracle
database remains unchanged(immutable), it is only new data gets appeneded.  So,
the software is expected to run the same way irrespective of data updates.

The instuctions for database refresh is [here](Oracle-database-sync.md)

