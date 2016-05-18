Feature: Running the 'pdf' command

  Background:
    Given the default aruba exit timeout is 20 seconds
    Given I have an Indoctrinatr project 'demo'
    When  I successfully run `indoctrinatr parse demo`

  Scenario: for a given 'demo' project
      And I run `indoctrinatr pdf demo`
     Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist

  Scenario: for a given 'demo' project and usage with tab-completion
      And I run `indoctrinatr pdf demo/`
     Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist

