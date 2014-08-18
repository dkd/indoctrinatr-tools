Feature: Running the "demo" command

  Background:
    Given the default aruba timeout is 5 seconds

  Scenario:
     When I successfully run `indoctrinatr demo`
     Then a file named "demo_with_default_values.pdf" should exist
      And a directory named "demo" should exist
      And a directory named "demo/assets" should exist
      And the following files should exist:
        | demo/configuration.yaml           |
        | demo/demo.tex.erb                 |
        | demo/demo_with_default_values.tex |
        | demo_with_default_values.pdf      |
        | demo.zip                          |
