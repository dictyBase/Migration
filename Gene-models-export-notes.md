# Synonyms
* Export in a two columns tsv with GeneID and colon/command separated synonyms
* Integrate the export code in dicty gff3 exporter.
   * Add `read_synonym` & `write_synonym` events to current event driven data exporter
   * `write_synonym` happens as a part of `write_synonym` to avoid duplication
   * Added [`test`](https://github.com/dictyBase/Modware-Loader/commit/6bb3f32a6c7f22abcc6226fc1f4ea51e64f40a42). Broken as of Oct 11, 2013

# Summary paragraph 
* Export a three columns tsv with GeneID, paragraph text and curator name.
* Export user name(string) instead of database id.
* As an alternate export a file for each user/curator
* Exporting curator names as a column in output file. Can be separated too !
* Convert summary to mediawiki.
  * Get a list of xml tags and their possible markdown markup using HTML::WikiConverter.
  * Convert the original file to a two three columns tsv.
  * As the summary is neither XML nor HTML, added `<html>...</html>` tags to the clean formatted summary and then ran it through `html2wiki`
  * Consider the option of exporting paragraphs as an attribute of GFF3 Text too long. Also can have punctuations.


