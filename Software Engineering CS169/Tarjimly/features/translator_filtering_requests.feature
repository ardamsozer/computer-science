Feature: View Filtered Requests

  Scenario: Translator views request filtered by language
    Given I am on the "translators/requests" page
    When I filter by from and to language
    Then I should see a list of requests scoped by filter
