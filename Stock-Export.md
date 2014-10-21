# Phenotype/Genotype/Stock center data export

##Completed
### Strain
```perl
$_> modware-dump dictystrain -c strain_export.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictystrain -c strain_export.yaml --data genotype --data inventory --data genes --data publications # Specific exports
```

### Plasmid
```perl
$_> modware-dump dictyplasmid -c plasmid_export.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictyplasmid -c plasmid_export.yaml --data genbank --data genes # Specific exports
$_> modware-dump dictyplasmid -c plasmid_export.yaml --sequence # Export plasmid sequences in FastA/GenBank
```


## Left
### Stock orders


## Additional information

* [SQL Statements](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/export.md)
* [Discussions](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/discussions.md#stock-data-export-discussions)
* [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
* [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
* [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)


