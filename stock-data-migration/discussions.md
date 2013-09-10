# Stock Data Import Discussions

* ~~Create ontology with `cv.name` = 'dicty_stockcenter'~~
   * **Use `dbxref` only if an external unique identifier is present. DBS_ID is an internal identifier**
   * ~~Cvterm belonging to the above `cv` will have `cvterm.name` = [strain, plasmid]~~
* Phenotype model
   * ~~Ask for data from Sol Genomics.~~ *on their contact form (Aug 15, 2013)* 
      * Understand how tomato is modelled for phenotypes
   * Study & understand [Chado Phenotype Module at FlyBase](http://gmod.org/wiki/Chado_Phenotype_Module_at_FlyBase)
* [Random generation of unique ID for stock](https://github.com/dictyBase/Modware-Loader/issues/80)
   * Understand how we randomly generate DBS IDs for `strain` in Oracle
   * Look for similar functionality in PostgreSQL. Investigate deep. Have sample code !
      * `SELECT md5(random()::text);`
   * ~~See if use of UUID will be possible~~ It generates a alpha-numeric string of the form 8-4-4-12 characters
* `Cv` namespaces, when unknown. What is the default? 
   * [What `type_id` should be used in `phenstatement`?](http://gmod.827538.n3.nabble.com/About-type-id-in-phenstatement-td4036285.html)
   * When is `environment` linked to `cv` through `environment_cvterm`?
   * What `cvterm` can be used for phenotype notes? Look up ontologies on OBO Foundry. Also look for terms in PATO

# Stock Data Export Discussions

* Storing organism information
   * What if *discoideum AX4* is resequenced? How do we distinguish current *AX4* genome from the new one?
   * What if we have genomes from 2 strains for a particular species and there is no sub-species?
   
* [**How to deal with Stock Orders?**](https://github.com/dictyBase/Modware-Loader/issues/81)

* From the legacy strain data `obtained_as`, `keywords` & `phenotype` will be GONE !
* There are 3 types of references for each strain & plasmid.
   * `internal_db_id` has some custom IDs of the form **d[0-9]{4}**. 87 entries with no PubMed reference for strains.
   * `other_references` also has IDs of the form **d[0-9]{4}**. 23 entries with no PubMed reference for strains. 
   * ~~Export above 2 IDs to one separate file with DBS_ID~~ 
* Genotype:
   * The order of comma separated genotypes is important. For example, one genotype is `axeA2,axeB2,axeC2,ptnA-[PTEN-BSR],bsR`
   * Find out how many strain-gene links have an associated genotype. **ALL. If not, create the link**
   * ~~Generate **DSC_G[0-9]{7}** ID for `genotype.uniquename`~~
* Plasmid:
   * Plasmid are linked to genes based on **sequence**
   * ~~**Get plasmid sequence files & convert to GenBank or FastA format**~~
   * Plasmids do NOT have an organism.
      * ~~From plasmid-gene link find out an organism for the one's that do have~~. (Not required)
   * ~~Should we generate **DBP_IDs** for plasmids (like DBS_IDs for strains)? **YES**~~
* Phenotype:
   * ~~**Figure out how environment ontology is used (strain-phenotype)**~~
   * ~~Figure out SQL for strain phenotypes displayed on the web; [example](http://dictybase.org/db/cgi-bin/dictyBase/phenotype/strain_and_phenotype_details.pl?genotype_id=1516)~~
* Strain
   * The `strain.phenotype` is currently free text, comma separated. It is a combination of strain characteristics, genotype and phenotypes.
      * ~~Strip all the genotype & strain characteristic terms. Export DBS_ID & just the phenotype (non genotype & non strain charcateristic terms)~~
      * Map these exported phenotype terms to __dicty phenotype ontology__

* Data (database columns) that will NOT exported
   * Strain
      * `strain_type`, `keywords`, `obtained_from`, `strain_verification`, `obtained_on`
      * **Strain Inventory** - `stored_from`, `date_of_viability_test`, `viability_test_results`, `viability_test_performed_by`, `date_transferred_to_ln`, `date_of_strain_plating`, `plating_results`, `strain_verification`, `created_by`, `date_created`, `stored_by`, `date_modified`
   * Plasmid
      * `obtained_on`, `obtained_as`, `created_by`, `date_created`, `date_modified` 
      * **Plasmid Inventory** - `test_date`, `verification`, `stored_by`, `created_by`, `date_created`, `date_modified` 

* [Flatfile for Stock - Chado schema mailing list](http://gmod.827538.n3.nabble.com/Flat-file-representation-for-Stock-module-from-Chado-td4030589.html)
