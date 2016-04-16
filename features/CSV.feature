Feature: CSV
  As a director
  I want to download a list of the members in my team as a CSV
  So that I can better organize them.

Background:
  
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
  Then I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I follow "Add to Team"
  Then I follow "Logout"


Scenario: Testing CSV when everything works

	Given I log in as "p@example.com" with password "password" 
	Then I follow "Teams"
	Then I follow "View"
	Then follow "Print CSV for project1"
	Then I should get a download with the filename "project1_roster.csv"
	

@wip
Scenario: CSV with empty team
	Given I am logged in as a Training_Director
	And I am leading the team "SadTeam"
	Then I go to the Dancers Page
	Then I follow CSV
	Then I should see "There are no dancers in your team"

Scenario: CSV without leading a team
	Given I log in as "admin@example.com" with password "password" 
	Then I follow "Teams"
	Then I follow "View"
	Then follow "Print CSV for project1"
	Then I should get a download with the filename "project1_roster.csv"
