## Exporting gene models
The majority of its is already taken care of as a part of gff3 exports. The exports also include other dictyostelid genomes. 
The process is documented [here](http://dictybase.github.io/blog/2013/03/06/exporting-discoideum-annotations/). For the other genomes, the __chado2canonicalgff3__ command has to used.

__Note:__There will be a need for exporting faked intron gene models, however it will be done after its data model in chado have been finalized.

## Exporting gene model annoations
These would be primarilly the additional information added during curation.

### Synonyms
#### ETA(~1 day)
* Export in a two columns tsv with GeneID and colon/command separated synonyms
  * Integrate the export code in dicty gff3 exporter.

### Summary paragraph
#### ETA(~3 days)
* Export a  threee columns tsv with GeneID, paragraph text and curator name.
  *  __Note:__Export user name(string) instead of database id.
  * As an alternate export a file for each user/curator.

* Convert xml to markdown text.
  * Get a list of xml tags and their possible markdown markup.
  * Convert the original file to a two columns tsv.

