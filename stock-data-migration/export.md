### SQL for stock data export

```sql
/* Strain */
SELECT d.accession, sc.species, sc.strain_name,  sc.strain_description
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```
```sql
/* Strain inventory */
SELECT d.accession, sci.location, sci.color, sci.no_of_vials, sci.obtained_as, sci.stored_as, sci.storage_date, sci.storage_comments private_comment, sci.other_comments_and_feedback public_comment
FROM CGM_DDB.stock_center_inventory sci
JOIN CGM_DDB.stock_center sc ON sc.id = sci.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```
```sql
/* Strain publications */
SELECT sc.strain_name, sc.pubmedid, sc.internal_db_id, sc.other_references
FROM CGM_DDB.stock_center sc;
```
```sql
/* Strain genotype */
SELECT d.accession, sc.strain_name, sc.genotype
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```
```sql
/* Strain phenotype */
SELECT sc.strain_name, sc.phenotype
FROM CGM_DDB.stock_center sc;
```
```sql
/* Strain gene link */
SELECT DISTINCT d.accession strain_id, d2.accession gene_id
FROM CGM_DDB.strain_gene_link sgl
JOIN CGM_DDB.stock_center sc ON sc.id = sgl.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.feature f ON f.feature_id = sgl.feature_id
JOIN CGM_CHADO.dbxref d2 ON d2.dbxref_id = f.dbxref_id;
```
```sql
/* Strain characteristics */
SELECT DISTINCT d.accession, ct.name
FROM CGM_DDB.strain_char_cvterm scc
JOIN CGM_DDB.stock_center sc ON sc.id = scc.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.cvterm ct ON ct.cvterm_id = scc.cvterm_id;
```
```sql
/* Plasmid */
SELECT id, name, description
FROM CGM_DDB.plasmid;
```
```sql
/* Plasmid inventory */
SELECT p.id, pi.location, pi.color, pi.stored_as, pi.storage_date, pi.other_comments_and_feedback public_comment
FROM CGM_DDB.plasmid_inventory pi
JOIN CGM_DDB.plasmid p ON p.id = pi.plasmid_id;
```
```sql
/* Plasmid gene link */
SELECT DISTINCT p.id plasmid_id, d.accession gene_id
FROM plasmid_gene_link pgl
JOIN CGM_DDB.plasmid p ON p.id = pgl.plasmid_id
JOIN CGM_CHADO.feature f ON f.feature_id = pgl.feature_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = f.dbxref_id;
```
```sql
/* Plasmid - GenBank accession number */
SELECT id, genbank_accession_number
FROM CGM_DDB.plasmid
WHERE genbank_accession_number IS NOT NULL;
```
---
```sql
/* Phenotype */
SELECT g.uniquename dbs_id, phen.name phenotype, env.name environment, assay.name assay, pub.uniquename pmid, p.value phenotype_note
FROM phenstatement pst
LEFT JOIN genotype g on g.genotype_id = pst.genotype_id
LEFT JOIN cvterm env on env.cvterm_id = pst.environment_id
LEFT JOIN cv env_cv on env_cv.cv_id = env.cv_id
LEFT JOIN phenotype p on p.phenotype_id = pst.phenotype_id
LEFT JOIN cvterm phen on phen.cvterm_id = p.observable_id
LEFT JOIN cvterm assay on assay.cvterm_id = p.assay_id
LEFT JOIN cv assay_cv on assay_cv.cv_id = assay.cv_id
LEFT JOIN pub on pub.pub_id = pst.pub_id
ORDER BY g.uniquename, pub.uniquename, phen.name;
```
---
