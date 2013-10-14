# Basic guidelines
* Please put a link to all of our done assignments, commit bits, code API docs,
  user docs, passing of unit tests in CI etc. whichever or which combination
  makes sense in the context of assignment. Any lack of the above will keep it incomplete.
* Make sure the expectations/assignments are clear before you start.
* The assignment is not completed until reviewed. The easier you make it for reviewing, the faster it will be to completion.
* Make sure to just add links for your assignment, do not modify any other content.

# 7th - 11th Oct
* Chado sql building script for Chado-Sqitch.
* Migrate gene summary. 
* Write docs about using Modware-Loader to do stock center data migration. Put it as a documentation in our dictybase [blog](http://dictybase.github.io/pages/documentation/)

# 14th - 18th Oct
* Write docs about using Modware-Loader to do stock center data migration. Put it as a documentation in our dictybase [blog](http://dictybase.github.io/pages/documentation/)
* Chado sql building script for Chado-Sqitch.
* Export gene models (Was migrate gene summary).
* Import plasmid sequence.
* Add perlcritic to your code workflow.
* Clean up modware-loader issue tracker. There are tons of issues floating
  there, if they are not supposed to be completed now, change their label or
  delete those labels, take some actions.
* Staging loader for gene ontology annotations data. Remember the
  module/class should be independent of data format(GAF/GPAD), it should work
  irrespective of the flat file source.
  - The code should completed with unit tests(~95% coverage) 
  - Support for two backends
  - Complete API docs in POD
  - At the end build should pass in CI

# 21th - 25th Oct
* Staging loader for gene ontology annotations data(contd.)

# 28th - 1 Nov
* Chado loader for gene ontology annotations data. The expectation is identical to staging loader.

# 4th Nov - 8th Nov
* Chado loader for gene ontology annotations data.(contd.)
* Write GAF,GPAD and GPI exporter for chado. The expectation is identical to staging loader.
  - Write down the exporting design in terms of class, module and how they
    interact. It should be a loosely coupled design where each class should
    have a defined responsibility. Monolithic design is totally discouraged.
  - All exporter will be plugable.
  - A event driven design is recommended.
  - Before you start, have a discussion to clear out each pieces.

# 11th Nov - 15th Nov
* Application module for gene ontology annotations data.
  - Should be able to export in multiple formats as required.
* Write GAF,GPAD and GPI exporter for chado(contd..). 

# 18th Nov - 22nd Nov
* Backend API desing phaseI.
  - Further broken down assignments will appear later.
