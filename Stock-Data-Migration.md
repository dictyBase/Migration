## Stock data export/import

### Export stock data 
_ETA ~ 4 days (07/15 - 07/19)_

####  Export strain data 

| Data | Columns | Chado table (target) | Comments |
| --- | --- | --- | --- |
| ~~strain~~ | `dbs_id`, `dbxref_id`, `species`, `strain_name`, `strain_description` | `stock` | **Handle `organisms` which have genomes and no strain information** |
| ~~inventory~~ | `dbs_id`, `location`, `color`, `storage_date`, `no_of_vials`, `obtained_as`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | `stockprop` | |
| publications | `dbs_id`, `pubmed_id` | `stock_pub` | There are references other than PubMed | |
| ~~genes~~ | `dbs_id`, `dbxref.accession` (gene_id) | `stock_dbxref` | |
| ~~genotype~~ | `dbs_id`, `strain_descriptor` (strain_name), `genotype` | `stock_genotype` | [Example][1] |
| phenotype | `dbs_id`, `phenotype` (cvterm_name) | `stock_cvterm` | Get `strain.phenotype terms` mapped to `phenotype ontology terms`. Strip terms that are `genotype` or `strain_characteristics` |
| ~~characteristics~~ | `dbs_id`, `cvterm_name` | `stock_cvterm` | |

```perl
modware-dump dictystrain -c strain-dump.yaml # This will dump all data
modware-dump dictystrain -c strain-yaml --data genotype,inventory,genes # If something specific needs to be exported
```

* There are 3 types of references for each strain & plasmid.
   * `internal_db_id` has some custom IDs of the form **d[0-9]{4}**. 87 entries with no PubMed reference for strains.
   * `other_references` also has IDs of the form **d[0-9]{4}**. 23 entries with no PubMed reference for strains. 
   * Export above 2 IDs to one separate file with DBS_ID 

* The `strain.phenotype` is currently free text, comma separated. It is a combination of strain characteristics, genotype and phenotypes.
   * Strip all the genotype & strain characteristic terms. Export DBS_ID & just the phenotype (non genotype & non strain charcateristic terms).
   * Map these exported phenotype terms to __dicty phenotype ontology__

**_Discussion_**
* Storing organism information
   * What if *discoideum AX4* is resequenced? How do we distinguish current *AX4* genome from the new one?
   * What if we have genomes from 2 strains for a particular species and there is no sub-species?

####  Export plasmid data

| Data | Columns | Chado table (target) | Comments |
| --- | --- | --- | --- |
| ~~plasmid~~ | `plasmid_id`, `name`, `description` | `stock` | Consider generating a `dbp_id` (DBP0000234) |
| ~~inventory~~ | `plasmid_id`, `location`, `color`, `storage_date`, `no_of_vials`, `obtained_as`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | `stockprop` | |
| publications | `plasmid_id`, `pubmed_id` | `stock_pub` | There are references other than PubMed |
| ~~genes~~ | `plasmid_id`, `dbxref.accession` (gene_id) | `stock_dbxref` | |
| ~~genbank~~ | `plasmid_id`, `genbank_accession_number` | `stock_dbxref` | |

```perl
modware-dump dictyplasmid -c plasmid-dump.yaml # This will dump all data
modware-dump dictyplasmid -c plasmid-dump.yaml --data genbank,inventory,genes # If something specific needs to be exported
```

[1]: http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516

### References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)

__Community Discussions__

1. [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
