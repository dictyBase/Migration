# Exporting gene models and annotations
## Completed
### Core model 
The process is documented
[here](http://dictybase.github.io/blog/2013/03/06/exporting-discoideum-annotations/).
For the other genomes, the __chado2canonicalgff3__ command has to used.

### Export polypeptides
Part of gff3 export.

### Synonyms
Part of gff3 export.

### Summary paragraph 
```perl
modware-export chado2genesummary -c config.yaml -o gene_summart.tsv
```

### Curator notes
```perl
modware-export curatornotes --dsn 'dbi:Oracle:....' --user user --pass pass --note public -o public.csv
modware-export curatornotes --dsn 'dbi:Oracle:....' --user user --pass pass --note private -o private.csv
```

### Colleagues genes association
```perl
modware-export colleague2gene --dsn 'dbi:Oracle:....' --user user --pass pass  -o coll2gene.tsv 
```

## Left
### Deleted gene models
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/129)
### Fake intron gene model
There will be a need for exporting faked intron gene models, however it will be done after its data model in chado have been finalized.
Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/123).

Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/126).

### Selenocystein modifications

Tracked [here](https://github.com/dictyBase/Modware-Loader/issues/124).

