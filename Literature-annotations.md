## Export literature
### ETA ~3 days

#### Understand bibtex format. In fact, any of the popular export format would be acceptable. __Completed__
#### Export in bibtex format
##### Export all pubmed entries(7419 July 16th)
* Check the entire export by importing them in jabref, mendeley and zotero etc. 
  Skip duplicates, however keep a note about them. __Completed__

```perl
$_> modware-export chadopub2bib [--options]
```

* Export records for other genomes.
    Here we only export those entries that are present in dicty database. __Completed__

    ```sql
      SELECT uniquename FROM dpur_chado.pub 
        where pub.pubplace = 'PUBMED'
        minus
      SELECT uniquename FROM cgm_chado.pub
       where pub.pubplace = 'PUBMED'
     ```
   
   Here we get a list of unique pubmed ids from dictygenomes database and then convert them into bibtex.

```perl
$_> modware-transform pub2bib [--options]
```


* Entries without doi needs to identified, then gets their full text url using elink. In bibtex use url tag for export. Not __high priority__

##### Export non-pubmed entries(4180)

Redundant entries,need data cleaning. The approach would be to figure out, 

* Redundant entries
* In case of merge provide a remap.

#### Explore how to manage the transfer of dictybase publication keywords.
    
    

## Export annotations
### ETA ~4 days
This will be primarilly list of genes tied to publications. 

* Export a two column tsv with pubmed id and dictybase GeneID.
* Export list of curated/not curated literature
  * Figure out type of data/columns needed for export. It should depend on storage model.
* Export curation assignment.
  * Figure out kind of export format it requires.
* Export date created

As usual, try to add a Modware-Loader export command for every tsv/alternate export.


## Note
If possible include the annotations in the bib file itself. For example,
* Date created: __timestamp__ 
* Keywords: __keywords__
* Still not sure about GeneID and curator assignments.

