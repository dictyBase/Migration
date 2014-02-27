# GAF Import

## Synopsis



## Tasks

* Understand OBO-loader for software design

### Mapping GPAD columns to chado tables

GPAD columns | Value   |         Chado mapping
------------------|---------|--------------
 1 (DB)            |1         |  None(ignored)
 2 **(DB_Object_id)**  |1        |  feature.uniquename/feature.dbxref -> feature_cvterm.feature_id 
 3 **(Qualifier)**     |>=1         |  feature.cvtermprop[value => qualifier] -> cvterm(qualifier) -> cv(gene_ontology_association)
 4  **(GO ID)**           | 1       |  cvterm.name(dbxref.accession) -> feature_cvterm.cvterm_id 
 5 **(DB_References)**  | >= 1        |  first one feature_cvterm.pub_id. The rest of them goes through feature_cvterm_pub
 6 **(Ev code)**        | 1        |  feature_cvtermprop[value => 1] -> cvterm(Full name of evidence code) -> cv(eco)
 7 (With/From)      | >= 0        |  feature_cvtermprop[value => with/form]  -> cvterm(with) -> cv(gene_ontology_association)
 8 (Taxon id)      | 1         |  None(ignored)
 9 **(Date)**          | 1         |  feature_cvtermprop[value => date]  -> cvterm(date) -> cv(gene_ontology_association)
 10 **(Assigned_by)**    | 1       |  feature_cvtermprop[value => assigned_by]  -> cvterm(source) -> cv(gene_ontology_association)
 11 (Annotation Extension) | >= 0 |  Yet to be modeled
 12 (Annotation Properties) |>= 0 |  None, ignored at this point, however could have curator assignment which have to be stored outside of chado schema




* Consider using temp tables and pure SQL for loading. [No *prune*](https://github.com/dictyBase/Modware-Loader/issues/41) everytime
* [Model Column 16](https://github.com/dictyBase/Modware-Loader/issues/21)
* [Unit tests](https://github.com/dictyBase/Modware-Loader/issues/38)
* [Support GPAD/GPI file formats](https://github.com/dictyBase/Modware-Loader/issues/51)

## Data

* GPAD will be available from EBI-GOA (QuickGO) 

```bash
curl -o gene_association.dictyBase http://www.ebi.ac.uk/QuickGO/GAnnotation\?format\=gpad\&db\=dictyBase\&limit\=-1
```

## Progress
### GPAD loader

It will be written in ```golang```.

* A [clone](https://github.com/dictyBase/testchado) of perl (Test::Chado)[https://github.com/dictyBase/Test-Chado] module in golang.
* A gpad loader written in golang.

## Software Design

Ref: [Design of Loader](https://github.com/dictyBase/Modware-Loader/issues/92)

## Discussions

* [Mailing list discussion on modeling Column 16](http://generic-model-organism-system-database.450254.n5.nabble.com/Storing-GO-annotation-extensions-in-Chado-td4564896.html)

* Provide proper curator information to Tony
* Making GPAD/GPI/GAF compatible. Import one format, export another.
