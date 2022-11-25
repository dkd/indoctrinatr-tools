Feature: Running the 'pdf' command with timestamp in filename
  Scenario: using the test fixture
    Given I use the fixture named "test"
     When I cd to "../"
      And I run the Indoctrinatr command 'parse test'
      And I run `indoctrinatr pdf test`
      # String interpolation for "file named should exist" does not work. Therefore less strict regexp matching:
     Then a file matching %r<test/doc/examples/\d{4}_hello_world\.pdf> should exist
