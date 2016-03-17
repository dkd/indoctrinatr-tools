Feature: Running the 'pdf' command

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
     When I successfully run `indoctrinatr parse demo`
      And I run `indoctrinatr pdf demo`
     Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist
    # there is not (an easy) way to use the current timestamp. Therefore the template for the 'new' command should not be static
