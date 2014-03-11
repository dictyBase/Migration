## Stock data export

### Times
@biodavidjm starts on 6 Mar 2014

Estimated finishing time
An expert should finish in 2.5 days
I expect to finish in 30 days (6 Apr 2014)

### Description
Exporting the data from Oracle


_Initial steps_ 
***
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

***
_end of initial steps_

**@biodavidjm on Stock Import**

Weekly review progress

### Week March 10 to 15

* Revised previous work (see above) and related projects
  * Studying "[Export Gene Models](https://github.com/dictyBase/Migration-Docs/blob/master/Gene-models-export.md)", which points directly to [Exporting D.discoideum Annotations in GFF3 Format](http://dictybase.github.io/blog/2013/03/06/exporting-discoideum-annotations/) 
* Installations:
  *  Sqitch (cpanm)
  *  Modware-loader
  
     ``sudo cpanm -n  git://github.com/dictyBase/Modware-Loader.git``
     
     		Successfully installed Modware-Loader-v1.6.0.
     		64 distributions installed
     		
     ``Modware-Loader`` (modware, modware-dump, modware-export, modware-import, modware-load, modware-transform  modware-update) requires the installation of additional modules to properly run. After running one by one and checking the errors associate to the missed modules, I installed the followings:
     
     ``sudo cpanm String::CamelCase``
     
     ``sudo cpanm DateTime::Format::Strptime``
     
     ``sudo cpanm -n  git://github.com/dictyBase/BioPortal-WebService.git``
     
     ``sudo cpanm BibTeX::Parser``
     
     After these installations, all the modware programs run without errors
 

