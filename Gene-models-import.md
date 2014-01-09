## Importing gene models
### Loading genomes in Pg backend
### ETA (~2 months). Took ~2 and half months.
~~GFF3 bulk loader.~~ A working version completed.

### Plugins for GFF3 bulk loader.
### ETA (~1 week).
The plugins would manipulate data loader by GFF3 loader which is beyond the scope of the loader.

### Misc
* Loading organism information to populate organism table in chado. However how do we __model strains__ and __resequenced strains__.
* Loading taxonomy from NCBI at least rooted at _amoebozoa._ (~ 2 weeks).


### Genomes to be loaded.
* _D.discoideum_. It does involve loading multiple GFF3 files in order. Loading the EST alignments 
    has to be skipped. New EST alignments needs to be generated.
* Genomes for other dictyostelids. It should one or two files per genomes. Other genomes should be loaded first.

#### Synopsis

```perl
modware-export gff3tochado -c config.yaml -i input.gff3
```

