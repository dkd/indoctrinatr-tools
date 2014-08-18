Feature: Checking autocompletion
  Scenario: Running the 'bashcompletion' command
    When I successfully run `indoctrinatr bashcompletion`
    Then the output should contain "get_indoctrinatr_targets()"

  Scenario: Running the 'zshcompletion' command
    When I successfully run `indoctrinatr zshcompletion`
    Then the output should contain "autoload -U +X bashcompinit && bashcompinit"
     And the output should contain "get_indoctrinatr_commands()"
