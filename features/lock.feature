Feature: Locking Teams
  As an admin
  I want for a series of checks to be implemented
  so that training teams cannot pick their roster until all project teams are locked in.

Background:
  Given I am on the Admin Login Page
  Given the following teams exist:
     | project  | name      | locked  | maximum_picks | id |
     | true     | project1  | false   | 40            | 1  |

  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
     | fake@example.com   | password  | password              | project     |         |
     | t@example.com      | password  | password              | training    |         |
  Given the following dancers exist:
     | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
     |                  | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | false        | 1   |
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |  

  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Logout" 
  
  
@wip
Scenario: Training team cannot pick until after project team does

@wip
Scenario: Training team locks in after project team
  Given the following teams exist:
  | project  | name      | locked  | maximum_picks | id |
  | false     | training1  | false   | 40            | 2  |
  Given I am on the Admin Login Page
  Then I log in as "t@example.com" with password "password"
  Then I follow "Teams"
  Then I go to the "admin/teams/2"
  
  
  
@wip
Scenario: Training team should not lock in before project team (sad path)
  
@wip
Scenario: Training team should not lock in more than X number of dancers

Scenario: Current user is not the director of team he/she is trying to lock
  Given I am on the Admin Login Page
  Then I log in as "fake@example.com" with password "password"
  Then I follow "Teams"
  Then I follow "View"
  Then I follow "Toggle Team Lock"
  Then I should see "You do not have ownership of project1"

@wip
Scenario: Final randomization after all training teams are locked in and no conflicts exist