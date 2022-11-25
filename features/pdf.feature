Feature: Running the 'pdf' command

  Background:
    Given the default aruba exit timeout is 20 seconds
      And I have an Indoctrinatr project 'demo'
      And I successfully run `indoctrinatr parse demo`

  Scenario: for a given 'demo' project
    When I run `indoctrinatr pdf demo`
    Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist

  Scenario: for a given 'demo' project and usage with tab-completion
    When I run `indoctrinatr pdf demo/`
    Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist
