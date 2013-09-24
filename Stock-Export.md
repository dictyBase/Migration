## Stock data export

###Synopsis

```perl
# Export strain data
$_> modware-dump dictystrain -c strain_export.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictystrain -c strain_export.yaml --data genotype --data inventory --data genes --data publications # Specific exports

# Export plasmid data
$_> modware-dump dictyplasmid -c plasmid_export.yaml --output_dir <folder-to-export-data> # This will dump all data
$_> modware-dump dictyplasmid -c plasmid_export.yaml --data genbank --data genes # Specific exports
$_> modware-dump dictyplasmid -c plasmid_export.yaml --sequence # Export plasmid sequences in FastA/GenBank
```

#### Deferred

* Stock orders

### [SQL Statements](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/export.md)
### [Discussions](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/discussions.md#stock-data-export-discussions)
### Old References

1. [Data Model(s)](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/models/stock_inventory.md)
2. [Data statistics](https://github.com/dictyBase/Stock-Data-Migration/blob/develop/data/stats.md)
3. [Data migrated so far](https://github.com/dictyBase/Stock-Data-Migration/issues/3)
