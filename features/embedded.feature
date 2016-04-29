Feature: Embedded Videos
	As an User
	So that I can easily access a dancer's casting video
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
     |                  | Dancer2   | test2@test.com| 999-999-9999    | 4       | Male        | false       | 2    |
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |
  Given the following casting_groups exist:
    | video											| id |
    | https://www.youtube.com/watch?v=6FNDIz1FeE0	| 1	 |

Scenario: The embedded video should match the dancer's casting group video
  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  Then I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I follow the view with number "1"
  Then I should see "https://www.youtube.com/watch?v=6FNDIz1FeE0"

Scenario: The dancer has not been associated with a casting video yet
  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  Then I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I follow the view with number "2"
  Then I should not see "https://www.youtube.com/watch?v=6FNDIz1FeE0"

