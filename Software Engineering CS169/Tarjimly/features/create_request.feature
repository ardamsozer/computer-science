Feature: create a new request

  So that I can create a translation request and provide context to translators
  I want to be able to select a From and a To language, add a title, description
  and select pre-determined categories (required)

  Background: go to new request page
    Given I go to the "new_request" page

  Scenario: successfully create a new request
    When I fill in "request_title" with "Cucumber Test Request"
    And I fill in "request_description" with "Cucumber Test Description"
    And I fill in "request_document" with "Cucumber Test Document"
    And I select "English" from "request_from_language"
    And I select "Arabic" from "request_to_language"
    And I fill in "request_deadline" with "2097-08-08"
    And I check "request_categories_legal"
    And I click the "Create Request" button
    Then I should be on the "/requests" path
    And I select "Pending Translations"
    And I should see "Cucumber Test Request"
    And I should see "Legal"

  Scenario: forget to fill in a field
    When I fill in "request_title" with "Cucumber Test Request"
    And I click the "Create Request" button
    Then I should be on the "/requests/new" path

