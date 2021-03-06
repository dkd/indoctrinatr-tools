Feature: Running the "demo" command

  Background:
    Given the default aruba exit timeout is 60 seconds

  Scenario:
    When I successfully run `indoctrinatr demo`
    Then a file named "demo/doc/demo_technical_documentation.pdf" should exist
     And a directory named "demo" should exist
     And a directory named "demo/assets" should exist
     And the following files should exist:
       | demo/configuration.yaml                        |
       | demo/demo.tex.erb                              |
       | demo/doc/examples/demo_with_default_values.tex |
       | demo/doc/examples/demo_with_default_values.pdf |
       | demo/doc/demo_technical_documentation.pdf      |
       | demo.zip                                       |
