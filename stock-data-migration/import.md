### Data model (SQL) to import stock (strain, plasmid) data

---
* The values for `obtained_as` and `stored_as` are themselves ontology terms.
* **Question?** - Should the value for `obtained_as` and `stored_as` be the `cvterm_id` of its values *OR* the value itself?

```sql
/* Strain inventory */
select s.uniquename, ct.name, sp.value
from stockprop sp
join stock s on s.stock_id = sp.stock_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv cv2 on cv2.cv_id = ct.cv_id
join cvterm invent on invent.cvterm_id = sp.type_id
join cv on cv.cv_id = invent.cv_id
where cv.name = 'strain_inventory'
and invent.name in ('location','color','number of vials','obtained as','stored as','storage date','private comment','public comment')
and ct.name = 'strain'
and cv2.name = 'dicty_stockcenter';
```
---
* 50 plasmids have associated GenBank accession numbers.
* **Question?** - Should the Genbank accession numbers be stored as `dbxref_id` in the `stock` table itself **OR** in the `stock_dbxref` table as suggested below?

```sql
/* Plasmid - GenBank */
select s.uniquename, d.accession
from stock_dbxref sd
join stock s on s.stock_id = sd.stock_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv on cv.cv_id = ct.cv_id
join dbxref d on d.dbxref_id = sd.dbxref_id
join db on db.db_id = d.db_id
where db.name = 'GenBank'
and ct.name = 'plasmid'
and cv.name = 'dicty_stockcenter';
```
---
* 163 plasmids have sequences in either GenBank or FastA formats.
* **Question?** - How to model this? How to link plasmids to genes?

```sql
/* Not sure yet! */
```
---
* **Question?** - What term to use to denote the parent-child relationship? Should we stick only to the relationship ontology?

```sql
/* Parental Strain */
select s.uniquename, p.uniquename
from stock_relationship srel
join stock s on s.stock_id = srel.subject_id
join stock p on p.stock_id = srel.object_id
join cvterm ct on ct.cvterm_id = srel.type_id
where ct.name = 'derives_from';
```
---
```sql
/* Select strains */
select s.name, s.uniquename, s.description, o.genus, o.species
from stock s
join organism o on o.organism_id = s.organism_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv on cv.cv_id = ct.cv_id
where ct.name = 'strain'
and cv.name = 'dicty_stockcenter';
```
```sql
/* Strain characteristics */
select s.uniquename, ct.name
from stock_cvterm sc
join stock s on s.stock_id = sc.stock_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv on cv.cv_id = ct.cv_id
join cvterm ch on ch.cvterm_id = sc.cvterm_id
join cv ccv on ccv.cv_id = ch.cv_id
where ccv.name = 'strain_characteristics'
and ct.name = 'strain'
and cv.name = 'dicty_stockcenter';
```
```sql
/* Strain - Genes */
select s.uniquename, d.accession
from stock_genotype sg
join stock s on s.stock_id = sg.stock_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv on cv.cv_id = ct.cv_id
join feature_genotype fg on fg.genotype_id = sg.genotype_id
join feature f on f.feature_id = fg.feature_id
join dbxref d on d.dbxref_id = f.dbxref_id
join cvterm ftype on ftype.cvterm_id = f.type_id
where ct.name = 'strain'
and ftype.name = 'gene'
and cv.name = 'dicty_stockcenter';
```
```sql
/* Strain genotype */
select s.uniquename, g.uniquename
from stock_genotype sg
join stock s on s.stock_id = sg.stock_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv on cv.cv_id = ct.cv_id
join genotype g on g.genotype_id = sg.genotype_id
where ct.name = 'strain'
and cv.name = 'dicty_stockcenter';
```
```sql
/* Strain Phenotype */
select s.uniquename, ct.name
from stock s
join stock_genotype sg on sg.stock_id = s.stock_id
join phenstatement pst on pst.genotype_id = sg.genotype_id
join phenotype p on p.phenotype_id = pst.phenotype_id
join cvterm ct on ct.cvterm_id = p.observable_id
join cv on cv.cv_id = ct.cv_id
where cv.name = 'dicty_phenotype';
```
```sql
/* Strain properties */
select s.uniquename, ct.name, sp.value
from stockprop sp
join stock s on s.stock_id = sp.stock_id
join cvterm ctr on str.cvterm_id = s.type_id
join cv dsc = dsc.cv_id = str.cv_id
join cvterm ct on ct.cvterm_id = sp.type_id
join cv on cv.cv_id = ct.cv_id
where cv.name = 'dicty_stockcenter'
and ct.name in ('mutagenesis method', 'mutant type', 'synonym')
and str.name = 'strain'
and dsc.name = 'dicty_stockcenter';
```
```sql
/* Strain/Plasmid publications */
select s.uniquename, pub.uniquename
from stock_pub sp
join stock s on s.stock_id = sp.stock_id
join cvterm ct on ct.cvterm_id = s.type_id
join cv on cv.cv_id = ct.cv_id
join pub on pub.pub_id = sp.pub_id
where ct.name in ('strain', 'plasmid')
and cv.name = 'dicty_stockcenter';
```
