## Exporting gene models
## Core model [Completed]
The process is documented [here](http://dictybase.github.io/blog/2013/03/06/exporting-discoideum-annotations/). For the other genomes, the __chado2canonicalgff3__ command has to used.

## Fake intron gene model
There will be a need for exporting faked intron gene models, however it will be done after its data model in chado have been finalized.
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/123).

## Exporting gene model annoations
### Synonyms [Completed]
Part of gff3 export.
#### Notes
* Export in a two columns tsv with GeneID and colon/command separated synonyms
* Integrate the export code in dicty gff3 exporter.
   * Add `read_synonym` & `write_synonym` events to current event driven data exporter
   * `write_synonym` happens as a part of `write_synonym` to avoid duplication
   * Added [`test`](https://github.com/dictyBase/Modware-Loader/commit/6bb3f32a6c7f22abcc6226fc1f4ea51e64f40a42). Broken as of Oct 11, 2013

### Summary paragraph [Completed]
```perl
modware-export chado2genesummary -c config.yaml -o gene_summart.tsv
```
#### Notes
* Export a three columns tsv with GeneID, paragraph text and curator name.
* Export user name(string) instead of database id.
* As an alternate export a file for each user/curator
* Exporting curator names as a column in output file. Can be separated too !
* Convert summary to mediawiki.
  * Get a list of xml tags and their possible markdown markup using HTML::WikiConverter.
  * Convert the original file to a two three columns tsv.
  * As the summary is neither XML nor HTML, added `<html>...</html>` tags to the clean formatted summary and then ran it through `html2wiki`
  * Consider the option of exporting paragraphs as an attribute of GFF3 Text too long. Also can have punctuations.

### Private curator notes
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/124).

### Colleagues genes association
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/125).





