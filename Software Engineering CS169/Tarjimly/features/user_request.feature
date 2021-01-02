Feature: display all my submitted requests

  As an aidworker
  So that I can easily access my submitted requests
  I want to be routed to my profile page after I log in
  And see a sorted list of all pending jobs in my "Pending Translations" tab
  And see all completed requests in my "Completed Translations" tab

  Background: requests have been created

    Given the following requests exist:
      | user_tarjimly_id | from_language | to_language | document | document_format | deadline   | title                  | description | categories    | num_claims | form_type | _status |
      | 1              | English       | Arabic      | location | pdf             | 2019-11-09 | Camp Announcment       | information | Refugee, Camp | 1          | N/A       | 1       |
      | 1              | English       | Urdu        | location | pdf             | 2019-11-10 | Camp Announcment Flyer | information | Refugee, Camp | 0          | N/A       | 0       |
      | 1              | Arabic        | English     | location | pdf             | 2019-12-09 | Visa Application       | information | Visa          | 2          | Visa      | 1       |
      | 1              | Urdu          | English     | location | pdf             | 2019-11-01 | Doctor Notes           | information | Child, Doctor | 1          | N/A       | 0       |

    And I go to the "Requests" page

  Scenario: see all pending requests
    When I select "Pending Translations"
    Then I should see "Camp Announcment Flyer"
    And I should see "Doctor Notes"

  Scenario: see all completed requests
    When I select "Completed Translations"
    Then I should see "Camp Announcment"
    And I should see "Visa Application"