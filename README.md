#Entry point for overhaul project

## Conventions
+ The project should link to mostly work in progress documentation, finished one is also acceptable.
+ The link could be internal markdown or external.
+ Create subproject links if neccessary, however choose a name close to a one mentioned in __overhaul__ document.

## Projects
* [Database versioning](/DB-versioning.md)
* [Unit testing](/Unit-testing.md)
* Data migration
   * Data Export from oracle
     * [Gene models/annotations](Gene-models-export.md)
     * [Literature/annotations](Literature-annotations.md)
     * [Stock/Phenotype](Stock-Export.md)
   * Data Import in Postgresql
     * [Gene models/annotations](Gene-models-import.md)
	 * [GAF](GAF-Import.md)
     * [Ontologies](Ontology-import.md)
     * [Literature](Literature-import.md)
     * [Stock/Phenotype](Stock-Import.md) 
* Backend data access
* Frontend Web UI
* Batch processing
* Server setup
* Software deployment
* Misc
* Third party tools
 
## Important note
Support for non-ascii characters for all projects

## Oracle Notes

**Note:** Ask sidd for addresses for all servers.

### Syncing from prod to testdb using MacOSX

* Install [Cord](http://cord.sourceforge.net/)
* Login to ts-nubic server using ts-nubic server.
* Go to dump_scripts folder and run export_dicty_prod.bat
* Copy DICTY_PROD_CHADO.DMP and DICTY_PROD_DDB.DMP to dictytst.
* Now run import_production_to_test.bat
* Make zip archive of dump file using current datestamps.

**Note:** After migration to 11g please point to 11g server before you run import_production_to_test.bat

### Sync developer machine.
* Login to nubic oracle vm for developer.
* Mount ts-nubic using samba/cifs filesystem.
* Copy the zipped dump(done above).
* Run the import script.
* Install and configure sqldeveloper(if you haven't already) and then do a cursory check of both dicty and dicty_legacy schema.
  Prefereably run a count statement.,
