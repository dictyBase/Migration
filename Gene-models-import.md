## Importing gene models
### Loading genomes in Pg backend
### ETA (~2 months). Took ~2 and half months.
~~GFF3 bulk loader.~~ A working version completed.

### Plugins for GFF3 bulk loader.
### ETA (~1 week).
The plugins would manipulate data loader by GFF3 loader which is beyond the scope of the loader.

### Misc
* [Specification](https://github.com/dictyBase/Migration-Docs/issues/5) for pre and post-processing. 
* Loading taxonomy from NCBI at least rooted at _amoebozoa._ (~ 2 weeks). **Could be skipped now**

#### Generate EST alignments for available species. 
* Experiment and figure out the tool to use for alignments.
* Generate standard GFF3 output of alignments(using Target tag) and load it through GFF3 loader.



### Genomes to be loaded.
* *D.discoideum:* It does involve loading multiple GFF3 in order.
* Genomes for other dictyostelids. It should one or two files per genomes. Other genomes should be loaded first.

#### Synopsis

```perl
modware-export gff3tochado -c config.yaml -i input.gff3
```

