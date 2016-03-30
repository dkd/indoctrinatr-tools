Feature: Running the 'doc' command with keepauxfiles

  Background:
    Given the default aruba exit timeout is 40 seconds

  Scenario: creating documentation for given project
    Given I do not have a 'demo' project
    When I successfully run `indoctrinatr new demo`
    And I successfully run `indoctrinatr doc demo --keepauxfiles`
    Then the output should match /A documentation for 'demo' has been successfully generated/
    Then a file named "demo/doc/demo_technical_documentation.pdf" should exist
    And a file named "demo/doc/indoctrinatr-technical-documentation.log" should exist
    And a file named "demo/doc/indoctrinatr-technical-documentation.tex" should exist
