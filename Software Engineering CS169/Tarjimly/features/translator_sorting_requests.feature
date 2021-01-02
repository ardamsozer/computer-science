Feature: View Sorted Requests

  Scenario: Translator views request sorted by deadline
    Given I am on the "translators/requests" page
    When I sort by deadline
    Then I should see a list of requests sorted
