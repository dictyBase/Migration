## Stock data export/import

### Export stock data 
_ETA ~ 4 days (07/15 - 07/19)_

####  Export strain data 

| Data | Columns | Total entries | Chado table (target) | Comments |
| --- | --- | --- | --- | --- |
| ~~strain~~ | `dbs_id`, `dbxref_id`, `species`, `strain_name`, `strain_description` | 5948 |  `stock` | Completed on 07/17 |
| ~~inventory~~ | `dbs_id`, `location`, `color`, `storage_date`, `no_of_vials`, `obtained_as`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | 2369 | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `dbs_id`, `pubmed_id` & `dbs_id`, `internal_db_id` | 5133 & 331 | `stock_pub` | Completed on 07/19 | 
| ~~genes~~ | `dbs_id`, `dbxref.accession` (gene_id) | 1498 | `stock_dbxref` | Completed on 07/17 |
| ~~genotype~~ | `dbs_id`, `strain_descriptor` (strain_name), `genotype` | 2657 | `stock_genotype` | [Example][1]. Completed on 07/17 |
| phenotype | `dbs_id`, `phenotype` (cvterm_name) | | `stock_cvterm` | Work in progress... |
| ~~characteristics~~ | `dbs_id`, `cvterm_name` | 17168 | `stock_cvterm` | Completed on 07/17 |

```perl
$_> modware-dump dictystrain -c strain-dump.yaml # This will dump all data
$_> modware-dump dictystrain -c strain-yaml --data genotype,inventory,genes # Specific exports
```

* There are 3 types of references for each strain & plasmid.
   * `internal_db_id` has some custom IDs of the form **d[0-9]{4}**. 87 entries with no PubMed reference for strains.
   * `other_references` also has IDs of the form **d[0-9]{4}**. 23 entries with no PubMed reference for strains. 
   * Export above 2 IDs to one separate file with DBS_ID 

* The `strain.phenotype` is currently free text, comma separated. It is a combination of strain characteristics, genotype and phenotypes.
   * Strip all the genotype & strain characteristic terms. Export DBS_ID & just the phenotype (non genotype & non strain charcateristic terms).
   * Map these exported phenotype terms to __dicty phenotype ontology__

####  Export plasmid data

| Data | Columns | Total entries | Chado table (target) | Comments |
| --- | --- | --- | --- | --- |
| ~~plasmid~~ | `plasmid_id`, `name`, `description` |  | `stock` | Completed on 07/17 |
| ~~inventory~~ | `plasmid_id`, `location`, `color`, `storage_date`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `plasmid_id`, `pubmed_id` | | `stock_pub` | Completed on 07/19 |
| ~~genes~~ | `plasmid_id`, `dbxref.accession` (gene_id) | | `stock_dbxref` | Completed on 07/17 |
| ~~genbank~~ | `plasmid_id`, `genbank_accession_number` | | `stock_dbxref` | Completed on 07/17 |

```perl
$_> modware-dump dictyplasmid -c plasmid-dump.yaml # This will dump all data
$_> modware-dump dictyplasmid -c plasmid-dump.yaml --data genbank,genes # Specific exports
```

#### Discussion
* Storing organism information
   * What if *discoideum AX4* is resequenced? How do we distinguish current *AX4* genome from the new one?
   * What if we have genomes from 2 strains for a particular species and there is no sub-species?
* Should we generate **DBP_IDs** for plasmids (like DBS_IDs for strains)?

[1]: http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516

### References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)

__Community Discussions__

1. [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
