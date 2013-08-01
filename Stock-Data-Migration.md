## Stock data export/import

###Synopsis

```perl
# Export strain data
$_> modware-dump dictystrain -c strain-dump.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictystrain -c strain-yaml --data genotype,inventory,genes,publications,phenotype,props # Specific exports

# Export plasmid data
$_> modware-dump dictyplasmid -c plasmid-dump.yaml --output_dir <folder-to-export-data> --sequence_file # This will dump all data
$_> modware-dump dictyplasmid -c plasmid-dump.yaml --data genbank,genes # Specific exports
```

### Discussion
* Storing organism information
   * What if *discoideum AX4* is resequenced? How do we distinguish current *AX4* genome from the new one?
   * What if we have genomes from 2 strains for a particular species and there is no sub-species?
* Should we generate **DBP_IDs** for plasmids (like DBS_IDs for strains)? **YES**

* From the legacy strain data `obtained_as`, `keywords` & `phenotype` will be GONE !
* Genotype:
   * Genotype currently **NOT** used for linking genes to strains.
   * The order of comma separated genotypes is important. For example, one genotype is `axeA2,axeB2,axeC2,ptnA-[PTEN-BSR],bsR`
   * Find out how many strain-gene links have an associated genotype. **ALL. If not, create the link**
* Plasmid:
   * Plasmid are linked to genes based on **sequence**
   * **Get plasmid sequence files & convert to GenBank format**. **Done**
   * Plasmids do NOT have an organism.
      * From plasmid-gene link find out an organism for the one's that do have.
* Phenotype:
   * **Figure out how environment ontology is used (strain-phenotype)**

### Export stock data 
_ETA ~ ~~6 days (07/15 - 07/22)~~. Estimated 3 days_

####  Export strain data 

| Data | Columns | Total entries | Chado table (target) | Comments |
| --- | --- | --- | --- | --- |
| ~~strain~~ | `dbs_id`, `dbxref_id`, `species`, `strain_name`, `strain_description` | 5948 |  `stock` | Completed on 07/17 |
| ~~inventory~~ | `dbs_id`, `location`, `color`, `storage_date`, `no_of_vials`, `obtained_as`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | 2369 | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `dbs_id`, `pubmed_id` & `dbs_id`, `internal_db_id` | 5133 & 331 | `stock_pub` | Completed on 07/19 | 
| ~~genes~~ | `dbs_id`, `dbxref.accession` (gene_id) | 1498 | `stock_genotype` | Completed on 07/17. `stock_genotype -> feature_genotype -> feature`. |
| ~~genotype~~ | `dbs_id`, `genotype` (comma separated) | | `stock_genotype` | [Example][1]. Completed on 07/17. Redo export. |
| ~~phenotype~~ | `dbs_id`, `phenotype` (cvterm_name) | | | Completed on 07/22. |
| ~~characteristics~~ | `dbs_id`, `cvterm_name` | 17168 | `stock_cvterm` | Completed on 07/17 |
| ~~props~~ (synonyms, genetic modifications, mutagenesis methods) | `dbs_id`, `type`, `value` | | `stockprop` |  |

* There are 3 types of references for each strain & plasmid.
   * `internal_db_id` has some custom IDs of the form **d[0-9]{4}**. 87 entries with no PubMed reference for strains.
   * `other_references` also has IDs of the form **d[0-9]{4}**. 23 entries with no PubMed reference for strains. 
   * Export above 2 IDs to one separate file with DBS_ID 
* The `strain.phenotype` is currently free text, comma separated. It is a combination of strain characteristics, genotype and phenotypes.
   * Strip all the genotype & strain characteristic terms. Export DBS_ID & just the phenotype (non genotype & non strain charcateristic terms).
   * Map these exported phenotype terms to __dicty phenotype ontology__
* Generate **DSC_G[0-9]{7}** ID for `genotype.uniquename`
* Figure out SQL for strain phenotypes displayed on the web; [example](http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516)

```sql
SELECT sc.strain_name, d.accession dbs_id, f.uniquename gene_symbol, d2.accession gene_id, ct.name phenotype
/* p.value, g.genotype_id, p.phenotype_id, p.observable_id */
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.genotype g ON g.uniquename = d.accession

JOIN CGM_CHADO.phenstatement pst ON pst.genotype_id = g.genotype_id
JOIN CGM_CHADO.phenotype p ON p.phenotype_id = pst.phenotype_id
JOIN CGM_CHADO.cvterm ct ON ct.cvterm_id = p.observable_id

JOIN CGM_CHADO.feature_genotype fg ON fg.genotype_id = g.genotype_id
JOIN CGM_CHADO.feature f ON f.feature_id = fg.feature_id
JOIN CGM_CHADO.dbxref d2 ON d2.dbxref_id = f.dbxref_id

WHERE g.genotype_id IN (1630, 1516)
AND sc.strain_name IN ('vasP-', 'sadA-')
ORDER BY sc.strain_name, d.accession;
```
OR
```sql
SELECT DISTINCT sc.strain_name, d.accession dbs_id, f.uniquename gene_symbol, d2.accession gene_id, ct.name phenotype
/* p.value, g.genotype_id, p.phenotype_id, p.observable_id */
FROM CGM_DDB.strain_gene_link sgl
JOIN CGM_DDB.stock_center sc ON sc.id = sgl.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.feature_genotype fg ON fg.feature_id = sgl.feature_id

JOIN CGM_CHADO.phenstatement pst ON pst.genotype_id = fg.genotype_id
JOIN CGM_CHADO.phenotype p ON p.phenotype_id = pst.phenotype_id
JOIN CGM_CHADO.cvterm ct ON ct.cvterm_id = p.observable_id

JOIN CGM_CHADO.feature f ON f.feature_id = fg.feature_id
JOIN CGM_CHADO.dbxref d2 ON d2.dbxref_id = f.dbxref_id

WHERE fg.genotype_id IN (1630, 1516)
AND sc.strain_name IN ('vasP-', 'sadA-')
ORDER BY sc.strain_name, d.accession;
```

####  Export plasmid data

| Data | Columns | Total entries | Chado table (target) | Comments |
| --- | --- | --- | --- | --- |
| ~~plasmid~~ | `plasmid_id`, `name`, `description` |  | `stock` | Completed on 07/17 |
| ~~inventory~~ | `plasmid_id`, `location`, `color`, `storage_date`, storage_comments (`private_comment`), other_comments_and_feedback (`public_comment`), `stored_as` | | `stockprop` | Completed on 07/17 |
| ~~publications~~ | `plasmid_id`, `pubmed_id` | | `stock_pub` | Completed on 07/19 |
| ~~genes~~ | `plasmid_id`, `dbxref.accession` (gene_id) | | | Completed on 07/17 |
| ~~genbank~~ | `plasmid_id`, `genbank_accession_number` | | `stock_dbxref` | Completed on 07/17 |
| ~~sequence~~ | | | | Completed on 08/01 |
| images | | | | Work in progress... |


### Import stock data

* Create ontology with `cv.name` = 'dicty_stockcenter'
   * Cvterm belonging to the above `cv` will have `cvterm.name` = [strain, plasmid]
   
**Notes**:
* Use `dbxref` only if an external unique identifier is present. DBS_ID is an internal identifier

#### Import strain data
_ETA ~ 3 days (07/23 - 07/25)_

* `stock` and `feature` (genes) are linked through `stock -> stock_genotype -> genotype -> feature_genotype -> feature`
* `DBS_ID` goes to `stock.uniuqename` and **NOT** to `dbxref.accession`
* 'Genetic Modification' & 'Mutagenesis Method' will be saved in `stockprop`
   * 'Genetic Modification' & 'Mutagenesis Method' will be `cvterm.name` under `cv.name` = 'dicty_stockcenter'
* 'Parental strain' & 'Strain Plasmid'
   * Data will go to `stock_relationship`
   * Look in `relationship_ontology` for terms like `parent_of` & `related_to`
   * Parental strain's `stock_id` will be `object_id` with `type_id` like `parent_of`
   * Plasmid's (linked to strain) `stock_id`  will be `subject_id` with `type_id` like `related_to`

#### Import plasmid data

* Plasmid sequence & map images
   * Get sequence & images from existing files
   * Data goes to `stockprop` with `type_id` as `sequence` & `image` (maybe).
   * Image saved as binary blob

[1]: http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516

### References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)

__Community Discussions__

1. [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
