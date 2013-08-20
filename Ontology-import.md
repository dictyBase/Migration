# Loading ontology
The documentation is [here](http://dictybase.github.io/obo-loading/index.html) and [here](http://dictybase.github.io/obo-loader/index.html). 
The current project is to get a fully working version with Pg backend.

## Core data

* Get a working version with postgresql identical to the one we have now for ```oracle``` and ```sqlite```.

  1. Write the temp table sql statements to a file and load it from there.  __Done__
  2. Load alt id.
  3. Load relationship properties.
  4. Load dbxrefs.

### Common tasks for all steps.
* Implement model both for ```sqlite``` and ```postgresql```.
* Write unit tests for those pieces.
* Write sql model(ER diagram) and documentation.
* Write code documentation(optional)

#### Setting up unit test with Test::Chado
* Implement loading of custom preset/ontology.

#### Writing unit test
* First a single test file which mocks the command line. Then check for data model.
* Optionally write unit test for each class and roles. Would be difficult to mock though.


## Relationships with transitive closure
This will be filling up the ```cvterm_path``` table.
