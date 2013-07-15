## Stock/Phenotype data export/import

### Exporting stock data

####  Exporting strain data ( ETA ~ 2 days )

* Export strain data 
   * Columns exported `dbs_id, dbxref_id, organism_id, strain_name, strain_description, type_id (strain), is_obsolete (false)`
	
* Export strain inventory
   * Columns exported `dbs_id, location, color, storage_date, no_of_vials, obtained_as, storage_comments (private_comment), other_comments_and_feedback (public_comment), stored_as`

* Export strain publications
   * Columns exported `dbs_id, pubmed_id`

*  Export strain-feature (linking)
   * Columns exported `dbs_id, feature_id`

* Export strain genotype
   * Columns exported `dbs_id, strain_descriptor, genotype`
   * Ref: [Strain details - _sadA-_](http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516)

* Export strain phenotype
   * Columns exported `dbs_id, phenotype`

### References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)

__Community Discussions__

1. [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
