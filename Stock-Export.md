## Stock data export

###Synopsis

```perl
# Export strain data
$_> modware-dump dictystrain -c strain_export.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictystrain -c strain_export.yaml --data genotype --data inventory --data genes --data publications # Specific exports

# Export plasmid data
$_> modware-dump dictyplasmid -c plasmid_export.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictyplasmid -c plasmid_export.yaml --data genbank --data genes # Specific exports
$_> modware-dump dictyplasmid -c plasmid_export.yaml --sequence # Export plasmid sequences in FastA/GenBank
```

### [SQL Statements](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/export.md)

### Data NOT exported
* Strain
   * `strain_type`, `keywords`, `obtained_from`, `strain_verification`, `obtained_on`
   * **Strain Inventory** - `stored_from`, `date_of_viability_test`, `viability_test_results`, `viability_test_performed_by`, `date_transferred_to_ln`, `date_of_strain_plating`, `plating_results`, `strain_verification`, `created_by`, `date_created`, `stored_by`, `date_modified`
* Plasmid
   * `obtained_on`, `obtained_as`, `created_by`, `date_created`, `date_modified` 
   * **Plasmid Inventory** - `test_date`, `verification`, `stored_by`, `created_by`, `date_created`, `date_modified` 


### Discussion
* Storing organism information
   * What if *discoideum AX4* is resequenced? How do we distinguish current *AX4* genome from the new one?
   * What if we have genomes from 2 strains for a particular species and there is no sub-species?
   
* **How to deal with Stock Orders?**
* From the legacy strain data `obtained_as`, `keywords` & `phenotype` will be GONE !
* There are 3 types of references for each strain & plasmid.
   * `internal_db_id` has some custom IDs of the form **d[0-9]{4}**. 87 entries with no PubMed reference for strains.
   * `other_references` also has IDs of the form **d[0-9]{4}**. 23 entries with no PubMed reference for strains. 
   * ~~Export above 2 IDs to one separate file with DBS_ID~~ 
* Genotype:
   * Genotype currently **NOT** used for linking genes to strains.
   * The order of comma separated genotypes is important. For example, one genotype is `axeA2,axeB2,axeC2,ptnA-[PTEN-BSR],bsR`
   * Find out how many strain-gene links have an associated genotype. **ALL. If not, create the link**
   * ~~Generate **DSC_G[0-9]{7}** ID for `genotype.uniquename`~~
* Plasmid:
   * Plasmid are linked to genes based on **sequence**
   * ~~**Get plasmid sequence files & convert to GenBank or FastA format**~~
   * Plasmids do NOT have an organism.
      * From plasmid-gene link find out an organism for the one's that do have.
   * ~~Should we generate **DBP_IDs** for plasmids (like DBS_IDs for strains)? **YES**~~
* Phenotype:
   * **Figure out how environment ontology is used (strain-phenotype)**
   * ~~Figure out SQL for strain phenotypes displayed on the web; [example](http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516)~~
* Strain
   * The `strain.phenotype` is currently free text, comma separated. It is a combination of strain characteristics, genotype and phenotypes.
      * ~~Strip all the genotype & strain characteristic terms. Export DBS_ID & just the phenotype (non genotype & non strain charcateristic terms)~~
      * Map these exported phenotype terms to __dicty phenotype ontology__


__ETA ~ ~~6 days (07/15 - 07/22)~~. Estimated 3 days__

### Export strain data 

| Data | Columns | Total entries | Chado table (target) | Status |
| --- | --- | --- | --- | --- |
| ~~strain~~ | `dbs_id`, `dbxref_id`, `species`, `strain_name`, `strain_description` | 5610 |  `stock` | Completed on 07/17 |
| ~~inventory~~ | `dbs_id`, `location`, `color`, `storage_date`, `no_of_vials`, `obtained_as`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | 2400 | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `dbs_id`, `pubmed_id` & `dbs_id`, `internal_db_id` | 5147 & 331 | `stock_pub` | Completed on 07/19. [Franke References in BibTeX](https://www.dropbox.com/s/ihn3n9zaz2w6r0u/dicty_refs_feb2012.bib) | 
| ~~genes~~ | `dbs_id`, `dbxref.accession` (gene_id) | 1498 | `stock_genotype` | Completed on 07/17. `stock_genotype -> feature_genotype -> feature`. |
| ~~genotype~~ | `dbs_id`, `genotype` (comma separated) | 387 | `stock_genotype` | [Example][1]. Completed on 07/17. Redo export. |
| ~~phenotype~~ | `dbs_id`, `phenotype` (cvterm_name) | 6703 | | Completed on 07/22. |
| ~~characteristics~~ | `dbs_id`, `cvterm_name` | 17203 | `stock_cvterm` | Completed on 07/17 |
| ~~props (synonyms, genetic modifications, mutagenesis methods)~~ | `dbs_id`, `type`, `value` | 13926 | `stockprop` | Completed |
| ~~parent~~ | `dbs_id`, `parent_dbs_id` | 15198 | `stock_relationship` | Completed |
| ~~plasmid~~ | `dbs_id`, `dbp_id OR plasmid_name` | 4325 | `stock_relationship` | Completed |

###  Export plasmid data

| Data | Columns | Total entries | Chado table (target) | Status |
| --- | --- | --- | --- | --- |
| ~~plasmid~~ | `plasmid_id`, `name`, `description` | 745 | `stock` | Completed on 07/17 |
| ~~inventory~~ | `plasmid_id`, `location`, `color`, `storage_date`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | 837 | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `plasmid_id`, `pubmed_id` | 566 | `stock_pub` | Completed on 07/19 |
| ~~genes~~ | `plasmid_id`, `dbxref.accession` (gene_id) | 533 | | Completed on 07/17 |
| ~~genbank~~ | `plasmid_id`, `genbank_accession_number` | 50 | `stock_dbxref` | Completed on 07/17 |
| ~~sequence~~ | | 168 | | Completed on 08/01 |
| images | | | | Work in progress... |
| ~~props (synonym, depositor, keywords)~~ |`dbp_id`, `type`, `value` | | `stockprop` | Work in progress... |


[1]: http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516

### Old References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)

__Community Discussions__

1. [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
