Feature: Running the 'parse' command

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
     When I successfully run `indoctrinatr parse demo`
     Then a file named "demo/demo_with_default_values.tex" should exist
