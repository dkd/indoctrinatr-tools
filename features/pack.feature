Feature: Running the 'pack' command

  Background:
    Given the default aruba exit timeout is 20 seconds

  Scenario:
    Given I have an Indoctrinatr project 'demo'
     When I successfully run `indoctrinatr parse demo`
      And I run `indoctrinatr pdf demo`
      And I run `indoctrinatr pack demo`
     Then a file named "demo.zip" should exist
