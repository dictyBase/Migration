/* Select strains */
SELECT *
FROM stock
JOIN cvterm ON cvterm.cvterm_id = stock.type_id
WHERE cvterm.name = 'strain';

/* Select plasmid */
SELECT *
FROM stock
JOIN cvterm ON cvterm.cvterm_id = stock.type_id
WHERE cvterm.name = 'plasmid';

/* Select strain characteristics */
SELECT d.accession, ct2.name
FROM stock_cvterm sc
JOIN stock ON stock.stock_id = sc.stock_id
JOIN cvterm ct1 ON ct1.cvterm_id = stock.type_id
JOIN dbxref d ON d.dbxref_id = stock.dbxref_id
JOIN cvterm ct2 ON ct2.cvterm_id = sc.cvterm_id
JOIN cv ON cv.cv_id = ct2.cv_id
WHERE ct1.name = 'strain'
AND cv.name = 'strain_characteristics';

/* Select genes associated with strains */
SELECT d1.accession, stock.name, d2.accession, feature.uniquename
FROM stock_dbxref
JOIN stock ON stock.stock_id = sd.stock_id
JOIN cvterm on cvterm.cvterm_id = stock.type_id
JOIN dbxref d1 ON d1.dbxref_id = stock.dbxref_id
JOIN feature ON feature.dbxref_id = sd.dbxref_id
JOIN dbxref d2 ON d2.dbxref_id = feature.dbxref_id
WHERE cvterm.name = 'strain';

/* Select strain publications */
SELECT d.accession, pub.uniquename pmid
FROM stock_pub sp
JOIN stock ON stock.stock_id = sp.stock_id
JOIN cvterm ON cvterm.cvterm_id = stock.type_id
JOIN dbxref d ON d.dbxref_id = stock.dbxref_id
JOIN pub ON pub.pub_id = sp.pub_id
WHERE cvterm.name = 'strain';


