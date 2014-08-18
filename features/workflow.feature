Feature: Running the "workflow" command

  Scenario:
    When I successfully run `indoctrinatr workflow`
    Then the output should contain "new"
    Then the output should contain "parse"
    Then the output should contain "pdf"
    Then the output should contain "pack"
