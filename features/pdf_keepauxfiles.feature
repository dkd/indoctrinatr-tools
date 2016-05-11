Feature: Running the 'pdf' command with keepauxfiles option

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
    And I run `indoctrinatr pdf demo --keep-aux-files`
    Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist
    And a file named "demo/doc/examples/demo_with_default_values.log" should exist
    # there is not (an easy) way to use the current timestamp. Therefore the template for the 'new' command should not be static
