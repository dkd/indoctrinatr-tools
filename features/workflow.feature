Feature: Running the "workflow" command

  Scenario:
    When I successfully run `indoctrinatr workflow`
    Then the output should contain "new"
     And the output should contain "parse"
     And the output should contain "pdf"
     And the output should contain "check"
     And the output should contain "pack"
