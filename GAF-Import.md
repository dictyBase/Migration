# GAF Import

## Synopsis

```perl
modware-load dictygaf2chado -c config.yaml -i gene_association.dictyBase -l log/gaf_load.log
```

## Tasks

* Understand OBO-loader for software design
* Consider using temp tables and pure SQL for loading. [No *prune*](https://github.com/dictyBase/Modware-Loader/issues/41) everytime
* [Model Column 16](https://github.com/dictyBase/Modware-Loader/issues/21)
* [Unit tests](https://github.com/dictyBase/Modware-Loader/issues/38)
* [Support GPAD/GPI file formats](https://github.com/dictyBase/Modware-Loader/issues/51)

## Data

* GAF will be available from EBI-GOA (QuickGO) 

```bash
curl -o gene_association.dictyBase http://www.ebi.ac.uk/QuickGO/GAnnotation\?format\=gaf\&db\=dictyBase\&limit\=-1
```

## Software Design

Ref: [Design of Loader](https://github.com/dictyBase/Modware-Loader/issues/92)

## Discussions

1. [Mailing list discussion on modeling Column 16](http://generic-model-organism-system-database.450254.n5.nabble.com/Storing-GO-annotation-extensions-in-Chado-td4564896.html)
