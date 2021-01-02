Feature: delete a requested translation

    As a User
    So that I know I have succesfully deleted a requested
    I want to no longer see the doccument in my "Pending Translations" tab

    Background: current pending transactions

        Given the following requests exist:
            | user_tarjimly_id | from_language | to_language | document | document_format | deadline   | title            | description | categories    | num_claims | form_type | _status |
            | 1                | English       | Arabic      | location | pdf             | 2019-11-09 | Camp Announcment | information | Refugee, Camp | 1          | N/A       | 0       |
            | 1                | English       | Urdu        | location | pdf             | 2019-11-10 | Camp Flyer       | information | Refugee, Camp | 0          | N/A       | 0       |
            | 1                | Arabic        | English     | location | pdf             | 2019-12-09 | Visa Application | information | Visa          | 2          | Visa      | 0       |
            | 1                | Urdu          | English     | location | pdf             | 2019-11-01 | Doctor Notes     | information | Child, Doctor | 1          | N/A       | 0       |

        Given the following claims exist:
            | translator_tarjimly_id | _status | submitted_date | translation | translation_type | request_id |
            | 142                    | 0       | Arabic         | location    | pdf              | 1          |
            | 142                    | 0       | Urdu           | location    | pdf              | 3          |
            | 98                     | 0       | English        | location    | pdf              | 1          |
            | 14                     | 0       | English        | location    | pdf              | 2          |

    Scenario: visiting user's pending transactions
        Given I go to the "Requests" page


    Scenario: successfully deleting a translation
        Given I go to the "Requests" page
        And I select "Pending Translations"
        When I select "Camp Announcment"
        And I click the "Delete Request" button
        Then I should be on the "/requests" path
        Then I should see confirmation of deleting "Camp Announcment"
        When I refesh the page
        Then I should not see "Camp Announcment"