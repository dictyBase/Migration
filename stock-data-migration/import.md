```sql
/* Select strains */
SELECT *
FROM stock
JOIN cvterm ON cvterm.cvterm_id = stock.type_id
WHERE cvterm.name = 'strain';
```
| Data | Target (Chado column) | Comments |
| --- | --- | --- |
| strain_name | `stock.uniquename` | |
| dbs_id | `stock.dbxref_id` | where `dbxref.accession` is the DBS_ID |
| species | `stock.organism_id` | where `organism.genus` & `organism.species` is `split(/\s/, species)` |
| strain_description | `stock.description` | |
| | `stock.name` | Can be `NULL` |
| 'strain' | `stock.type_id` | where `cvterm.name` = 'strain' |

```sql
/* Select plasmid */
SELECT *
FROM stock
JOIN cvterm ON cvterm.cvterm_id = stock.type_id
WHERE cvterm.name = 'plasmid';
```
| Data | Target (Chado column) | Comments |
| --- | --- | --- |
| plasmid_name | `stock.uniquename` | |
| plasmid_id OR DBP_ID | `stock.dbxref_id` | where `dbxref.accession` is the plasmid_id/DBP_ID |
| `NULL` or dicty | `stock.organism_id` | |
| description | `stock.description` | |
| | `stock.name` | Can be `NULL` |
| 'plasmid' | `stock.type_id` | where `cvterm.name` = 'plasmid' |

* _How to store plasmid sequence?_

```sql
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
```

```sql
/* Select genes associated with strains */
SELECT d1.accession, stock.name, d2.accession, feature.uniquename
FROM stock_dbxref
JOIN stock ON stock.stock_id = sd.stock_id
JOIN cvterm on cvterm.cvterm_id = stock.type_id
JOIN dbxref d1 ON d1.dbxref_id = stock.dbxref_id
JOIN feature ON feature.dbxref_id = sd.dbxref_id
JOIN dbxref d2 ON d2.dbxref_id = feature.dbxref_id
WHERE cvterm.name = 'strain';
```

```sql
/* Select strain publications */
SELECT d.accession, pub.uniquename pmid
FROM stock_pub sp
JOIN stock ON stock.stock_id = sp.stock_id
JOIN cvterm ON cvterm.cvterm_id = stock.type_id
JOIN dbxref d ON d.dbxref_id = stock.dbxref_id
JOIN pub ON pub.pub_id = sp.pub_id
WHERE cvterm.name = 'strain';
```

