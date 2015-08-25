Feature: Running the 'pdf' command

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
     When I successfully run `indoctrinatr parse demo`
      And I run `indoctrinatr pdf demo`
     Then a file named "demo_with_default_values.pdf" should exist
