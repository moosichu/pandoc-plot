# Change log

pandoc-plot uses [Semantic Versioning](http://semver.org/spec/v2.0.0.html)

Release 0.3.0.0
---------------

* Added more examples.
* Added MacOS binaries built via Azure pipelines.
* BREAKING CHANGE: Parsing captions based on source file was not working. Captions format can be specified in the configuration file. This unfortunately changes the type signature of a few high-level functions.

Release 0.2.2.0
---------------

* Fixed an issue where paths with spaces would not work (issue #2).
* Added Linux binaries built via Azure pipelines.

Release 0.2.1.0
---------------

* Improved documentation.

Release 0.2.0.0
---------------

* Added support for gnuplot.
* Added more tests for all toolkits.

* Fixed an issue where the package could not be installed because a source file was not included in the cabal file.

Release 0.1.0.0
---------------

* Initial release