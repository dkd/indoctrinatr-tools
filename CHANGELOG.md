# 0.12.0 (10.05.2016)

## Feature additions

* added `check` command: This analyzes your template Pack for major issues ( #64232 )
* add `pdf_with_field_names` command ( #64694). This creates an example where the field names are shown
* add the Example with fieldnames to technical documentation ( #71536 ) - when it is successfully generated
* add `keep-aux-files` option to pdf generation ( #66118 )
* disable overwriting PDF examples for `doc` command ( #71535 )

## Changes

* Documentation doesn't break when description field is missing ( #65001 )
* @longtabu@ for attributes list in documentation ( #66081)
* move examples after Generation in `/doc` directory in Template Pack
* show attributes list documentation as landscape
* Refactoring