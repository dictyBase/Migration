## Exporting gene models
The majority of its is already taken care of as a part of gff3 exports. The exports also include other dictyostelid genomes. 
The process is documented [here](http://dictybase.github.io/blog/2013/03/06/exporting-discoideum-annotations/). For the other genomes, the __chado2canonicalgff3__ command has to used.

__Note:__There will be a need for exporting faked intron gene models, however it will be done after its data model in chado have been finalized.

## Exporting gene model annoations
These would be primarilly the additional information added during curation.

### Synonyms
#### ETA(~1 day). Took (~3 days)
* ~~Export in a two columns tsv with GeneID and colon/command separated synonyms~~
* Integrate the export code in dicty gff3 exporter.
   * Add `read_synonym` & `write_synonym` events to current event driven data exporter
   * `write_synonym` happens as a part of `write_synonym` to avoid duplication

### Summary paragraph
#### ETA (~3 days). Took (~3 days)
* Export a three columns tsv with GeneID, paragraph text and curator name.
  *  __Note:__ Export user name(string) instead of database id.
  * ~~As an alternate export a file for each user/curator~~ Exporting curator names as a column in output file. Can be separated too !

* Convert summary to mediawiki.
  * ~~Get a list of xml tags and their possible markdown markup~~ Using HTML::WikiConverter.
  * Convert the original file to a ~~two~~ three columns tsv.
  * As the summary is neither XML nor HTML, added `<html>...</html>` tags to the clean formatted summary and then ran it through `html2wiki`

* ~~Consider the option of exporting paragraphs as an attribute of GFF3~~ Text too long. Also can have punctuations.
