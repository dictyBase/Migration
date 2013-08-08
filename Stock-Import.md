## Stock data import

### Synopsis

```perl

```

### [Data Model](https://github.com/dictyBase/Migration-Docs/blob/master/stock-data-migration/import.md)

### Discussion

* Create ontology with `cv.name` = 'dicty_stockcenter'
   * Cvterm belonging to the above `cv` will have `cvterm.name` = [strain, plasmid]
   * Use `dbxref` only if an external unique identifier is present. DBS_ID is an internal identifier

### Import strain data


### Import plasmid data

* Plasmid sequence & map images
   * Get sequence & images from existing files
   * Data goes to `stockprop` with `type_id` as `sequence` & `image` (maybe).
   * Image saved as binary blob
