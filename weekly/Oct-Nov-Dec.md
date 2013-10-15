# Basic guidelines
* Please put a link to all of our done assignments, commit bits, code API docs,
  user docs, passing of unit tests in CI etc. whichever or which combination
  makes sense in the context of assignment. Any lack of the above will keep it incomplete.
* Make sure the expectations/assignments are clear before you start.
* The assignment is not completed until reviewed. The easier you make it for reviewing, the faster it will be to completion.
* Make sure to just add links for your assignment, do not modify any other content.

# 7th - 11th Oct
* Chado sql building script for Chado-Sqitch.
   * Generate SQL without functions/views - [`737fa47`](https://github.com/dictyBase/Chado-Sqitch/blob/737fa47895890a25d64b85b321480f6a0afb4085/maint/chado_nofuncs_noviews.pl) 
   * Added params to generate SQL with functions/views - [`b9817e1`](https://github.com/dictyBase/Chado-Sqitch/blob/b9817e1cde49a9e05d1b884f71984d9d07b34c6b/maint/chado_nofuncs_noviews.pl)
* Migrate gene summary - [docs](https://github.com/dictyBase/Migration-Docs/blob/master/Gene-models-export.md#summary-paragraph) 
   * Command to export geen summary as tab-delimited file - [`322ecfb`](https://github.com/dictyBase/Modware-Loader/blob/322ecfb5b93610dae0b636e3f2eb982d6593bffe/lib/Modware/Export/Command/chado2genesummary.pm)
      * Cleans up existing text, adds proper hrefs, makes it a proper html & converts to mediawiki using [`html2wiki`](https://metacpan.org/module/HTML::WikiConverter#html2wiki)
   * Added test to validated exported mediawiki. (requires Oracle backend) - [`8404fdb`](https://github.com/dictyBase/Modware-Loader/blob/8404fdbcbc0b9a2eee23bedb4ed2c28b7ea71834/t/export/gene_summary.t)
* Write docs about using Modware-Loader to do stock center data migration. Put it as a documentation in our dictybase [blog](http://dictybase.github.io/pages/documentation/)
   * Added documentation on stock data export commands - [`407c363`](https://github.com/dictyBase/dictybase.github.com/blob/407c363a415ac633f8241dd6585e45e3efea8304/source/stock-data-export/index.markdown)

# 14th - 18th Oct
* Write docs about using Modware-Loader to do stock center data migration. Put it as a documentation in our dictybase [blog](http://dictybase.github.io/pages/documentation/)
   * Documentation on stock data import commands - [``]()
* Chado sql building script for Chado-Sqitch.
   * Create `deploy, revert` scripts for Sqitch from Chado SVN modules checkout - [``]()
* Export gene models (Was migrate gene summary).
* Import plasmid sequence.
   * Model for plasmid sequence import
   * Import GenBank & FastA
* Add perlcritic to your code workflow - [`~/.perlcriticrc`](https://github.com/ypandit/dot-files/blob/master/perl/perlcriticrc)
* Clean up modware-loader issue tracker. There are tons of issues floating there, if they are not supposed to be completed now, change their label or delete those labels, take some actions.
   * 12 issues closed (added comments, links & [moved few to migration-docs](https://github.com/dictyBase/Migration-Docs/issues))
   * Added label `gaf2chado` for GAF related tasks. This will be handled in the coming weeks
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
