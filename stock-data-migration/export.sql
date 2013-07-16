/* Strain */
SELECT d.dbxref_id, sc.species, sc.strain_name, d.accession, sc.strain_description, 'strain', 'FALSE'
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;

/* Strain inventory */
SELECT sci.location, sci.color, sci.storage_date, sci.no_of_vials, sci.obtained_as, sci.storage_comments private_comment, sci.other_comments_and_feedback public_comment,sci.stored_as
FROM CGM_DDB.stock_center_inventory sci;

/* Strain publications */
SELECT sc.strain_name, sc.pubmedid
FROM CGM_DDB.stock_center sc;

/* Strain genotype */
SELECT d.accession, sc.strain_name, sc.genotype
FROM CGM_DDB.stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;

/* Strain phenotype */
SELECT sc.strain_name, sc.phenotype
FROM CGM_DDB.stock_center sc;

/* Strain gene link */
SELECT DISTINCT d.accession strain_id, d2.accession gene_id
FROM CGM_DDB.strain_gene_link sgl
JOIN CGM_DDB.stock_center sc ON sc.id = sgl.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.feature f ON f.feature_id = sgl.feature_id
JOIN CGM_CHADO.dbxref d2 ON d2.dbxref_id = f.dbxref_id;

/* Strain characteristics */
SELECT DISTINCT d.accession, ct.name
FROM CGM_DDB.strain_char_cvterm scc
JOIN CGM_DDB.stock_center sc ON sc.id = scc.strain_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id
JOIN CGM_CHADO.cvterm ct ON ct.cvterm_id = scc.cvterm_id;

/* Plasmid */
SELECT id, name, description
FROM CGM_DDB.plasmid;

/* Plasmid gene link */
SELECT DISTINCT p.id plasmid_id, d.accession gene_id
FROM plasmid_gene_link pgl
JOIN CGM_DDB.plasmid p ON p.id = pgl.plasmid_id
JOIN CGM_CHADO.feature f ON f.feature_id = pgl.feature_id
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = f.dbxref_id;

/* Plasmid - GenBank accession number */
SELECT id, genbank_accession_number
FROM CGM_DDB.plasmid
WHERE genbank_accession_number IS NOT NULL;
