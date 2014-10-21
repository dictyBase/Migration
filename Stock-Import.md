#Phenotype/Genotype/Strains/Stock center data import

## Completed
Run the following commands as a part of
[Modware-Loader](https://github.com/dictyBase/Modware-Loader) project.


### Strain
```perl
modware-import dictystrain2chado -c strain_import.yaml 
modware-import dictystrain2chado -c strain_import.yaml --prune --mock_pubs # Options to prune or mock publications 
modware-import dictystrain2chado -c strain_import.yaml --data inventory --data genotype # For specific imports 
modware-import dictystrain2chado -c strain_import.yaml --dsc_phenotypes <path-to-file> # Path to file with corrected DSC phenotypes 
```
### Plasmid
```perl
modware-import dictyplasmid2chado -c plasmid_import.yaml 
modware-import dictyplasmid2chado -c plasmid_import.yaml --mock_pubs --prune 
modware-import dictyplasmid2chado -c plasmid_import.yaml --data inventory --data props # For specific imports 
modware-import dictyplasmid2chado -c plasmid_import.yaml --seq_data_dir <path-to-folder> # Path tol folder with GanBank/FastA sequences
```
## Leftover
###Strain-gene link
### Stock orders
###Plasmid map images

## Additional information/notes
Its [here](Stock-Import-notes.md)
