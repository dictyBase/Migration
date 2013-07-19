## Export literature

__ETA__: ~3 days
Running: 4 days

### Export in bibtex format

#### Understand bibtex format. 

In fact, any of the popular export format would be acceptable. __Completed__

#### Export all pubmed entries(7419 July 16th)
* Check the entire export by importing them in jabref, mendeley and zotero etc. 
  Skip duplicates, however keep a note about them. __Completed__

```perl
$_> modware-export chadopub2bib [--options]
```

* Export records for other genomes. __Completed__

   Here we get a list of unique pubmed ids from dictygenomes database and then convert them into bibtex.

    ```sql
      SELECT uniquename FROM dpur_chado.pub 
        where pub.pubplace = 'PUBMED'
        minus
      SELECT uniquename FROM cgm_chado.pub
       where pub.pubplace = 'PUBMED'
     ```
   

```perl
$_> modware-transform pub2bib [--options]
```


* Entries without doi needs to identified, then gets their full text url using elink. In bibtex use url tag for export. Not __high priority__

#### Export non-pubmed entries(4180)


__Redundant entries__

| Non-pubmed source | Entries |
| --- | --- |
|    Hideko   |   1  |
| Curator |  20 |
| GO_REF | 40 |
| GENBANK | 1576 |
| ENDNOTE | 2535 |


* modware-loader script to export bibtex. The export also include the timestamp.

```shell
$_> modware-export dictynonpub2bib [..options]
```

* Write another script to update all __GENBANK__ entries, preferably update if it has a pubmed link. Then rerun the ```modware-export``` script.


__Remap__


__Some analysis__


```sql

WITH redpub AS
  (SELECT count(pub_id) counter,
      to_nchar(title) title
      FROM pub
      WHERE pubplace != 'PUBMED'
      GROUP BY to_nchar(title)
      HAVING COUNT(pub_id) > 1
      ORDER BY COUNT(pub_id) DESC
  ),
  topredpub AS (
     SELECT * from redpub where rownum = 1
  )
  SELECT * from topredpub
```

The above will retrieve top entry(602 rows) with identical __title.__ Now,the one ```sql statement``` below would get the features associated with one of them.

```sql

SELECT feature.name,feature.uniquename,cvterm.name FROM feature
  JOIN feature_pub fpub ON fpub.feature_id = feature.feature_id
  JOIN 
    (select pub.pub_id,pub.title,pubauthor.surname from pub,pubauthor,topredpub
     WHERE topredpub.title = to_nchar(pub.title)
     AND pubauthor.pub_id = pub.pub_id
     AND rownum = 1
    ) pentry ON pentry.pub_id = fpub.pub_id
  JOIN cvterm ON cvterm.cvterm_id = feature.type_id

```



#### Explore how to manage the transfer of dictybase publication keywords.

* Parse the bib entries(with pubmed ids) and add timestamp and keywords from the database.
* Use tsv for GeneID and curator assignments.

    
## Export annotations

__ETA__ ~4 days

This will be primarilly list of genes tied to publications. 

* Export a two column tsv with pubmed id and dictybase GeneID.
* Export list of curated/not curated literature
  * Figure out type of data/columns needed for export. It should depend on storage model.
* Export curation assignment.
  * Figure out kind of export format it requires.
* Export date created

As usual, try to add a Modware-Loader export command for every tsv/alternate export.



