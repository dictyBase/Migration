#Entry point for overhaul project

 
## Conventions
+ The project should link to mostly work in progress documentation, finished one is also acceptable.
+ The link could be internal markdown or external.
+ Create subproject links if neccessary, however choose a name close to a one mentioned in __overhaul__ document.

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
* Make zip archive of both dump files using current datestamps (named as dictyfull_YEARMONTHDATE)

**Note:** After migration to 11g please point to 11g server before you run import_production_to_test.bat

### Sync developer machine.
* Login to nubic oracle vm for developer.
* Mount ts-nubic using samba/cifs filesystem.
* Copy the zipped dump(done above).
* (Alternatively: connect from the mac on ts-nubic (smb://IP/folder/), and then scp the files to /dicty/DATADUMP/ on nubic-vm)
* Run the import script (./import_oradump.sh )
* Install and configure sqldeveloper(if you haven't already) and then do a cursory check of both dicty and dicty_legacy schema.
  Prefereably run a count statement.,

**Note:** Consult [bcwiki](http://bcwiki.bioinformatics.northwestern.edu/bcwiki/index.php/Importing_exporting_Oracle_10g_production_DB) for details.

### Sync last update

	* 17 October 2014 (test and developers. Password updated)
	* 8 September 2014 (test and developers)
	* 11 August 2014 (developers)
	* 14 July 2014 (test and developers)
	* 9  June 2014 (test and developers)
	* 12 May  2014 (test and developers)


### Server migration from 10g to 11g
Progress is logged [here](https://github.com/dictyBase/Migration-Docs/issues/9)

