# Loading ontology
The documentation is [here](http://dictybase.github.io/obo-loading/index.html) and [here](http://dictybase.github.io/obo-loader/index.html). 
The current project is to get a fully working version with Pg backend.

## Core data

* Get a working version with postgresql identical to the one we have now for ```oracle``` and ```sqlite```.

  1. Write the temp table sql statements to a file and load it from there.

* Write unit tests for those pieces.
* Implement rest of the model both for ```sqlite``` and ```postgresql```.


## Relationships with transitive closure
This will be filling up the ```cvterm_path``` table.
