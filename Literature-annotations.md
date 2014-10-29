# Export literature

## Completed
```perl
$_> modware-export chadopub2bib [--options] | modware-update dictybib [--options ]-o dictypub.bib
$_> cat share/dictygenome_pub.tsv | modware-transform pub2bib [--options] -o dictygenomespub.bib
$_> modware-export dictynonpub2bib [--options] -o dictynonpub.bib
$_> modware-export dictynonpub2bib [--options] -o dictygenomesnonpub.bib # skip now
$_> modware-export dictypubannotation [--options] -o dictypubannotation.csv
```
The annotations are exported in bibtex format. Additional notes are
[here](Literature-annotations-notes.md).

## Leftover
None.




