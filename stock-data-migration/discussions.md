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

