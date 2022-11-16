Feature: Running the 'new' command

  Scenario: with a valid name 'demo'
    Given I do not have a 'demo' project
     When I successfully run `indoctrinatr new demo`
     Then the output should match /A template pack scaffold was created in folder 'demo'. Happy templating…/
      And a directory named "demo" should exist
      And a directory named "demo/assets" should exist
      And the following files should exist:
        | demo/configuration.yaml |
        | demo/demo.tex.erb       |

  Scenario: with an empty name
    Given I do not have a 'demo' project
     When I run `indoctrinatr new`
     Then the exit status should be 1
      And the output should match /Please specify a template pack name/

  Scenario: with the same name as an existing directory
    Given I have an Indoctrinatr project 'demo'
     When I run `indoctrinatr new demo`
     Then the exit status should be 0
      And the output should match /A folder with name 'demo' already exists/
