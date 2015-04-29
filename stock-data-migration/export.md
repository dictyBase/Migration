STOCK_CENTER EXPORT
===

Check the file [`export_validation`](export_validation.md) for the analysis of the SQL statements found in this file.

```sql
/* Strain (6063) -> strain_strain.tsv (6063) */
SELECT d.accession, sc.species, sc.strain_name, sc.strain_description
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```

```sql
/* Strain inventory (2468) -> strain_inventory.tsv (2468) */
SELECT d.accession, sci.location, sci.color, sci.no_of_vials, sci.obtained_as, sci.stored_as, sci.storage_date, sci.storage_comments private_comment, sci.other_comments_and_feedback public_comment
FROM CGM_DDB.stock_center_inventory sci
JOIN CGM_DDB.stock_center sc ON sc.id = sci.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```

```sql
/* Strain publications (6063) -> strain_publications.tsv(5988), strain_publications_no_pubmed.tsv(1949) */
SELECT sc.strain_name, sc.pubmedid, sc.internal_db_id, sc.other_references
FROM CGM_DDB.stock_center sc;
```

```sql
/* Helpful SQL to explore bibliography */
SELECT sc.strain_name, sc.pubmedid, sc.internal_db_id, sc.other_references
FROM CGM_DDB.stock_center sc
WHERE sc.pubmedid is null AND (sc.OTHER_REFERENCES is not null AND REGEXP_LIKE(OTHER_REFERENCES, '^(d[0-9]{4}/)'))
```

```sql
/* Strain genotype (6063) -> strain_genotype.tsv */
SELECT d.accession, sc.strain_name, sc.genotype
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;
```

```sql
/* Strain phenotype (6063) -> strain_phenotype.tsv (7742) */
SELECT sc.strain_name, sc.phenotype
FROM CGM_DDB.stock_center sc;
```

```sql
/* Phenotype (7742) -> strain_phenotype.tsv */
SELECT g.uniquename dbs_id, phen.name phenotype, env.name environment, assay.name assay, pub.uniquename pmid, p.value phenotype_note
FROM phenstatement pst
LEFT JOIN genotype g on g.genotype_id = pst.genotype_id
LEFT JOIN cvterm env on env.cvterm_id = pst.environment_id
LEFT JOIN phenotype p on p.phenotype_id = pst.phenotype_id
LEFT JOIN cvterm phen on phen.cvterm_id = p.observable_id
LEFT JOIN cvterm assay on assay.cvterm_id = p.assay_id
LEFT JOIN pub on pub.pub_id = pst.pub_id
ORDER BY g.uniquename, pub.uniquename, phen.name;
```

```sql
/* Strain gene link (1498) -> strain_genes.tsv (1498) */
SELECT DISTINCT d.accession strain_id, d2.accession gene_id
FROM CGM_DDB.strain_gene_link sgl
JOIN CGM_DDB.stock_center sc ON sc.id = sgl.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.feature f ON f.feature_id = sgl.feature_id
JOIN CGM_CHADO.dbxref d2 ON d2.dbxref_id = f.dbxref_id;
```

```sql
/* Strain characteristics (19297) -> strain_characteristics.tsv (19297)*/
SELECT DISTINCT d.accession, ct.name
FROM CGM_DDB.strain_char_cvterm scc
JOIN CGM_DDB.stock_center sc ON sc.id = scc.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.cvterm ct ON ct.cvterm_id = scc.cvterm_id;
```

```sql
SELECT  d.accession, d2.accession gene_id, f.UNIQUENAME
FROM CGM_DDB.stock_center sc
JOIN CGM_DDB.strain_gene_link sgl ON sc.id = sgl.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.feature f ON f.feature_id = sgl.feature_id
JOIN CGM_CHADO.dbxref d2 ON d2.dbxref_id = f.dbxref_id
```

```sql
/* Plasmid (747) -> plasmid_plasmid.tsv (747)*/
SELECT id, name, description
FROM CGM_DDB.plasmid;
```

```sql
/* Plasmid inventory (835) -> plasmid_inventory.tsv (835)*/
SELECT p.id, pi.location, pi.color, pi.stored_as, pi.storage_date, pi.other_comments_and_feedback public_comment
FROM CGM_DDB.plasmid p
JOIN CGM_DDB.plasmid_inventory pi ON p.id = pi.plasmid_id;
```

```sql
/* Plasmid gene link (531) -> plasmid_genes.tsv (531)*/
SELECT DISTINCT p.id plasmid_id, d.accession gene_id
FROM plasmid_gene_link pgl
JOIN CGM_DDB.plasmid p ON p.id = pgl.plasmid_id
JOIN CGM_CHADO.feature f ON f.feature_id = pgl.feature_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = f.dbxref_id;
```

```sql
/* Plasmid - GenBank accession number (50) -> plasmid_genbank.tsv (50) */
SELECT id, genbank_accession_number
FROM CGM_DDB.plasmid
WHERE genbank_accession_number IS NOT NULL;
```

```sql
/* Stock Center Orders(1978) - Plasmids (1978) */
SELECT so.stock_order_id order_id, so.order_date, plasmid.id, plasmid.name, colleague.colleague_no, colleague.first_name, colleague.last_name, email.email
FROM cgm_ddb.plasmid
JOIN cgm_ddb.stock_item_order sio on
(
  plasmid.id=sio.item_id
  and
  plasmid.name=sio.item
)
JOIN cgm_ddb.stock_order so on sio.order_id=so.stock_order_id
LEFT JOIN cgm_ddb.colleague on colleague.colleague_no=so.colleague_id
LEFT JOIN cgm_ddb.coll_email coe on coe.colleague_no=colleague.colleague_no
LEFT JOIN cgm_ddb.email on email.email_no=coe.email_no;
```

```sql
/* Stock Center Orders(3132) - Strains (3132) */
SELECT so.stock_order_id order_id, so.order_date, sc.id id, sc.strain_name name, colleague.colleague_no, colleague.first_name, colleague.last_name, email.email
FROM cgm_ddb.stock_center sc
JOIN cgm_ddb.stock_item_order sio on
(
  sc.id=sio.item_id
  AND
  sc.strain_name=sio.item
)
JOIN cgm_ddb.stock_order so on sio.order_id=so.stock_order_id
LEFT JOIN cgm_ddb.colleague on colleague.colleague_no=so.colleague_id
LEFT JOIN cgm_ddb.coll_email coe on coe.colleague_no=colleague.colleague_no
LEFT JOIN cgm_ddb.email on email.email_no=coe.email_no;
```
