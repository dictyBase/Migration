/* Strain */
SELECT d.dbxref_id, sc.species, sc.strain_name, d.accession, sc.strain_description, 'strain', 'FALSE'
FROM stock_center sc
JOIN CGM_CHADO.dbxref d ON d.dbxref_id = sc.dbxref_id;

/* Strain inventory */
SELECT sci.location, sci.color, sci.storage_date, sci.no_of_vials, sci.obtained_as, sci.storage_comments private_comment, sci.other_comments_and_feedback public_comment,sci.stored_as
FROM stock_center_inventory sci;

/* Strain publications */
SELECT sc.strain_name, sc.pubmedid
FROM stock_center sc;

/* Strain genotype */
SELECT sc.strain_name, sc.genotype
FROM stock_center sc;

/* strain phenotype */
SELECT sc.strain_name, sc.phenotype
FROM stock_center sc;
