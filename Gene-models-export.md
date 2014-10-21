# Exporting gene models and annotations
## Completed
### Core model 
The process is documented [here](http://dictybase.github.io/blog/2013/03/06/exporting-discoideum-annotations/). For the other genomes, the __chado2canonicalgff3__ command has to used.

### Synonyms
Part of gff3 export.

### Summary paragraph 
```perl
modware-export chado2genesummary -c config.yaml -o gene_summart.tsv
```

## Left
### Fake intron gene model
There will be a need for exporting faked intron gene models, however it will be done after its data model in chado have been finalized.
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/123).

### Export polypeptides
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/126).

### Selenocystein modifications

### Private curator notes
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/124).

### Colleagues genes association
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/125).

