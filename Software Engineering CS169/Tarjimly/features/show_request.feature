Feature: view previously submitted request

    As a User
    So that I know I can view a previosuly
    I want to have a details page about

    Background: existing requested translations

        Given the following requests exist:
            | user_tarjimly_id | from_language | to_language | document | document_format | deadline   | title                  | description | categories    | num_claims | form_type | _status |
            | 1                | English       | Arabic      | location | pdf             | 2019-11-09 | Camp Announcment       | information | Refugee, Camp | 1          | N/A       | 0       |
            | 1                | English       | Urdu        | location | pdf             | 2019-11-10 | Camp Announcment Flyer | information | Refugee, Camp | 0          | N/A       | 0       |
            | 1                | Arabic        | English     | location | pdf             | 2019-12-09 | Visa Application       | information | Visa          | 2          | Visa      | 0       |
            | 1                | Urdu          | English     | location | pdf             | 2019-11-01 | Doctor Notes           | information | Child, Doctor | 1          | N/A       | 0       |

    Scenario: visiting request's details page
        Given I go to the "Requests" page
        And I select "Pending Translations"
        When I select "Camp Announcment"
        Then I should see "Details for Camp Announcment"
        Then I should see "Request Language" and "Translation Language"
        Then I should see "Deadline"

    Scenario: return to all requests
        Given I go to the "Requests" page
        And I select "Pending Translations"
        When I select "Camp Announcment"
        When I click the "All Requests" button
        Then I should be on the "/requests" path

