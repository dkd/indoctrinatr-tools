Feature: Running the 'pdf_with_field_names' command with keepauxfiles

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
     When I run `indoctrinatr pdf_with_field_names demo --keep-aux-files`
     Then a file named "demo/doc/examples/demo_with_fieldname_values.pdf" should exist
      And a file named "demo/doc/examples/demo_with_fieldname_values.log" should exist
