## Stock/Phenotype data export/import

### Exporting stock data

* Export strain data
   * Columns exported `dbxref_id, organism_id, strain_name, dbs_id, strain_description, type_id (strain), is_obsolete (false)`
	
* Export strain inventory
   * Columns exported `location, color, storage_date, no_of_vials, obtained_as, storage_comments (private_comment), other_comments_and_feedback (public_comment), stored_as`

* Export strain publications
   * Columns exported `strain_name, pubmed_id`

*  Export strain-feature (linking)
   * Columns exported `strain_name, feature_id`

* Export strain genotype
   * Columns exported `strain_name, genotype`  

* Export strain phenotype
   * Columns exported `strain_name, phenotype`

### Importing data

* Import strain characteristics ontology
* Import strain inventory ontology
* Import plasmid inventory ontology

### References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)

__Community Discussions__

1. [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
