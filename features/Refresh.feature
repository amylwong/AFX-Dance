Feature: Password Recovery
	As an User
	So that I can keep track of my dancer order
	I want to pick a dancer without reloading the page.

Background: Admin accounts exist
  Given I am on the Admin Login Page
  Given the following teams exist:
     | project  | name      | locked  | maximum_picks | id |
     | true     | project1  | false   | 40            | 1  |

  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
  Given the following dancers exist:
     | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
     | 1                 | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | true        | 1   |
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |
  Given the following casting_groups exist:
    | video											| id |
    | https://www.youtube.com/watch?v=6FNDIz1FeE0	| 1	 |

 Scenario: Page should not refresh
 	Given I am on the Admin Login Page
 	Then I log in as "p@example.com" with password "password"
 	Then I should see "Signed in successfully."
 	Then I follow "Dancers"
 	Then I follow "Add to Team"
 	Then page should not refresh