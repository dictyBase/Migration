## Export literature
### ETA ~3 days

#### Understand bibtex format. In fact, any of the popular export format would be acceptable. __Done__
#### Export in bibtex format
* Export all pubmed entries(7419 July 16th)
     * Have to check how many entries have __doi__. Depending on that probably have to do extra fetch using elink.
* Export non-pubmed entries(4180)
    * Redundant entries,need data cleaning. So, get some numbers about redundancies.
* Explore how to manage the transfer of dictybase publication keywords.
    
    

## Export annotations
### ETA ~4 days
This will be primarilly list of genes tied to publications. 

* Export a two column tsv with pubmed id and dictybase GeneID.
* Export list of curated/not curated literature
  * Figure out type of data/columns needed for export. It should depend on storage model.
* Export curation assignment.
  * Figure out kind of export format it requires.

As usual, try to add a Modware-Loader export command for every tsv/alternate export.

