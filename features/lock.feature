Feature: Locking Teams
  As an admin
  I want for a series of checks to be implemented
  so that training teams cannot pick their roster until all project teams are locked in.

Background:
  Given I am on the Admin Login Page
  
  Given the following casting_groups exist:
    | id | video                                       |
    | 1  | https://www.youtube.com/watch?v=GIooUZHGmYs |
    
  Given the following teams exist:
     | project  | name      | locked  | maximum_picks | id |
     | true     | project1  | false   | 1             | 1  |
     | false    | training1 | false   | 1             | 2  |

  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
     | fake@example.com   | password  | password              | project     |         |
     | t@example.com      | password  | password              | training    | 2       |
     
  Given the following dancers exist:
     | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
     |         1        | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | false       | 1   |
     |         1        | Dancer2   | test@test.com | 999-999-9999    | 4     | Male          | false       | 2   |
     
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |  

  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Logout" 
  
Scenario: Training team cannot pick until after project team does
  Given I am on the Admin Login Page
  Then I log in as "t@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Dancers"
  Then I follow the add view with number 1
  Then I should see "You cannot pick right now, project teams are still picking"
  
Scenario: Team should not lock in more than X number of dancers
  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Dancers"
  Then I follow the add view with number 1
  Then I should see "added to"
  Then I follow the add view with number 2
  Then I should see "You are over the maximum number of picks you can have"
  
Scenario: Current user is not the director of team he/she is trying to lock
  Given I am on the Admin Login Page
  Then I log in as "fake@example.com" with password "password"
  Then I follow "Teams"
  Then I follow the team view with number 1
  Then I follow "Toggle Team Lock"
  Then I should see "You do not have ownership of"