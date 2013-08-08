### SQL for stock data export

```sql
/* Strain */
SELECT d.accession, sc.species, sc.strain_name,  sc.strain_description
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```
```sql
/* Strain inventory */
SELECT sci.location, sci.color, sci.storage_date, sci.no_of_vials, sci.obtained_as, sci.storage_comments private_comment, sci.other_comments_and_feedback public_comment,sci.stored_as
FROM CGM_DDB.stock_center_inventory sci;
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
---
