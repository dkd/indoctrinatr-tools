Feature: Running the 'pdf' command

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario: for a given 'demo' project
    Given I have an Indoctrinatr project 'demo'
     When I successfully run `indoctrinatr parse demo`
      And I run `indoctrinatr pdf demo`
     Then a file named "demo/doc/examples/demo_with_default_values.pdf" should exist

  Scenario: with timestamp in filename
    Given I use the fixture named "test"
    When I cd to "../"
    When I run the Indoctrinatr command 'parse test'
    And I run `indoctrinatr pdf test`
    # String interpolation for "file named should exist" does not work. Therefore less strict regexp matching:
    Then a file matching %r<test/doc/examples/\d{4}_hello_world\.pdf> should exist
