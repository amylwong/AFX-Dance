Feature: Conflicts
  As a director 
  I want to prevent conflicted dancers from being locked in
  So that locked in teams do not have conflicted dancers.
  
Background:
  Given I am on the Admin Login Page
  
  Given the following casting_groups exist:
    | id | video                                       |
    | 1  | https://www.youtube.com/watch?v=GIooUZHGmYs |
    
  Given the following teams exist:
     | project  | name      | locked  | maximum_picks | id |
     | true     | project1  | false   | 40            | 1  |

  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Logout" 
  
Scenario: Locking roster with conflicted dancers
  Given the following dancers exist:
     | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
     |        1         | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | true        | 1   |
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |     
    
  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I follow "Add"
  Then I follow "Teams"
  Then I follow "View"
  Then I should see "Dancer1"
  Then I follow "Toggle Team Lock"
  Then I should see "There are dancer conflicts"
  Then I follow "Dancers"
  Then I should see "Conflicted"
  Then I should see "Yes"
  

Scenario: Locking roster without conflicted dancers
  Given the following dancers exist:
    | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
    |         1        | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | false       | 1   |
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         | 

  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I follow "Add"
  Then I follow "Teams"
  Then I follow "View"
  Then I should see "Dancer1"
  Then I follow "Toggle Team Lock"
  Then I should see "project1 has been locked"
  Then I follow "Toggle Team Lock"
  Then I should see "project1 has been unlocked"
  Then I follow "Dancers"
  Then I follow "Teams"
  Then I should see "No"

Scenario: Deleting a dancer from your team to remove conflicted
  Given the following dancers exist:
    | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
    |        1         | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | false        | 1   |
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |     
  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I follow "Add"
  Then I follow "Remove"
  Then I should see "have been deleted"