Feature: Running the 'doc' command

  Background:
    Given the default aruba exit timeout is 40 seconds
    Given I do not have a 'demo' project
    When I successfully run `indoctrinatr new demo`

  Scenario: creating documentation for given project
    And I successfully run `indoctrinatr doc demo`
    Then the output should match /Example with field names has been automatically generated for the documentation/
    Then the output should match /A documentation for 'demo' has been successfully generated/
    Then a file named "demo/doc/demo_technical_documentation.pdf" should exist

  Scenario: creating the documentation without overwriting a FieldNames PDF example
    And I successfully run `indoctrinatr pdf_with_field_names demo`
    Then a file named "demo/doc/examples/demo_with_fieldname_values.pdf" should exist
    And I successfully run `indoctrinatr doc demo`
    Then the output should not match /Example with field names has been automatically generated for the documentation/
    Then the output should match /A documentation for 'demo' has been successfully generated/
    Then a file named "demo/doc/demo_technical_documentation.pdf" should exist
