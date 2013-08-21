## Stock data import

### Synopsis

```perl

```

### [Data Model](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/import.md)

### Discussion

* ~~Create ontology with `cv.name` = 'dicty_stockcenter'~~
   * **Use `dbxref` only if an external unique identifier is present. DBS_ID is an internal identifier**
   * ~~Cvterm belonging to the above `cv` will have `cvterm.name` = [strain, plasmid]~~
* Phenotype model
   * ~~Ask for data from Sol Genomics.~~ *on their contact form (Aug 15, 2013)* 
      * Understand how tomato is modelled for phenotypes
   * Study & understand [Chado Phenotype Module at FlyBase](http://gmod.org/wiki/Chado_Phenotype_Module_at_FlyBase)
* Random generation of unique ID for stock
   * Understand how we randomly generate DBS IDs for `strain` in Oracle
   * Look for similar functionality in PostgreSQL. Investigate deep. Have sample code !
      * `SELECT md5(random()::text);`
   * ~~See if use of UUID will be possible~~ It generates a alpha-numeric string of the form 8-4-4-12 characters

### Import strain data
* Phenotype data model
   * The observation from expression of genotype is phenotype. Attributes observed can be affected by the environment
      * `genotype -> phenotype <- environment`
   * `dicty_environment` ontology will be loaded in `Cv::Cvterm`. However, which ever environment terms are associated with phenotype will also be duplicated in the `environment` table.
   * `dicty_assay` ontology is loaded in `Cv::Cvterm` and used in `Phenotype::Phenotype`. `dicty_assay` has nothing to do with `Mage::Assay`.  
   * ![Dicty Phenotype Data Model](stock-data-migration/images/dicty_phenotype.png)

### Import plasmid data

* Plasmid map images
   * ~~Get images from existing files~~
   * Data goes to `stockprop` with `type_id` as `image` (maybe).
   * Image saved as binary blob
