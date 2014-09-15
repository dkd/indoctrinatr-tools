Feature: Running the "version" command

  Scenario:
    When I successfully run `indoctrinatr version`
    Then the output should contain "0.0.13"
