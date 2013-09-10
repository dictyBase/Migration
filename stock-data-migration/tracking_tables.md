# Import strain data

# Import plasmid data

# Export strain data 

| Data | Columns | Total entries | Chado table (target) | Comments |
| --- | --- | --- | --- | --- |
| ~~strain~~ | `dbs_id`, `dbxref_id`, `species`, `strain_name`, `strain_description` | 5610 |  `stock` | Completed on 07/17 |
| ~~inventory~~ | `dbs_id`, `location`, `color`, `storage_date`, `no_of_vials`, `obtained_as`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | 2400 | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `dbs_id`, `pubmed_id` & `dbs_id`, `internal_db_id` | 5147 & 331 | `stock_pub` | Completed on 07/19. [Franke References in BibTeX](https://www.dropbox.com/s/ihn3n9zaz2w6r0u/dicty_refs_feb2012.bib) | 
| ~~genes~~ | `dbs_id`, `dbxref.accession` (gene_id) | 1498 | `stock_genotype` | Completed on 07/17. `stock_genotype -> feature_genotype -> feature`. |
| ~~genotype~~ | `dbs_id`, `dsc_g_id`, `genotype` (comma separated) | 387 | `stock_genotype` | [Example][1]. Completed on 07/17. Redo export. |
| ~~phenotype~~ | `dbs_id`, `phenotype` (cvterm_name) | 6703 | | Completed on 07/22. |
| ~~characteristics~~ | `dbs_id`, `cvterm_name` | 17203 | `stock_cvterm` | Completed on 07/17 |
| ~~props (synonyms, genetic modifications, mutagenesis methods)~~ | `dbs_id`, `type`, `value` | 13926 | `stockprop` | Completed |
| ~~parent~~ | `dbs_id`, `parent_dbs_id` | 15198 | `stock_relationship` | Completed |
| ~~plasmid~~ | `dbs_id`, `dbp_id OR plasmid_name` | 4325 | `stock_relationship` | Completed |

#  Export plasmid data

| Data | Columns | Total entries | Chado table (target) | Status |
| --- | --- | --- | --- | --- |
| ~~plasmid~~ | `plasmid_id`, `name`, `description` | 745 | `stock` | Completed on 07/17 |
| ~~inventory~~ | `plasmid_id`, `location`, `color`, `storage_date`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | 837 | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `plasmid_id`, `pubmed_id` | 566 | `stock_pub` | Completed on 07/19 |
| ~~genes~~ | `plasmid_id`, `dbxref.accession` (gene_id) | 533 | | Completed on 07/17 |
| ~~genbank~~ | `plasmid_id`, `genbank_accession_number` | 50 | `stock_dbxref` | Completed on 07/17 |
| ~~sequence~~ | | 168 | | Completed on 08/01 |
| images | | | | Work in progress... |
| ~~props (synonym, depositor, keywords)~~ |`dbp_id`, `type`, `value` | | `stockprop` | Completed |

[1]: http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516
