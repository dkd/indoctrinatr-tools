# indoctrinatr-tools

## v0.15.0 (2017-04-16)

### changes

* updated dependencies
* removed support for Ruby v2.1

## v0.14.0 (2016-09-14)

### changes

* updated dependencies

## v0.13.0 (2016-05-27)

### features

* support for trailing slashes in template pack name

### changes

* refactoring

## v0.12.0 (2016-05-10)

### features

* added `check` command: This analyzes your template pack for major issues (#64232)
* add `pdf_with_field_names` command (#64694). This creates an example where the field names are shown
* add the example with fieldnames to technical documentation (#71536) - when it is successfully generated
* add `keep-aux-files` option to pdf generation (#66118)
* disable overwriting PDF examples for `doc` command (#71535)

### changes

* documentation doesn't break when description field is missing (#65001)
* @longtabu@ for attributes list in documentation (#66081)
* move examples after generation in `/doc` directory in template pack
* show attributes list documentation as landscape
* refactoring
