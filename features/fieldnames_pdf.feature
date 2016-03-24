Feature: Running the 'pdf_with_field_names' command

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
    And I run `indoctrinatr pdf_with_field_names demo`
    Then a file named "demo_with_fieldname_values.pdf" should exist
