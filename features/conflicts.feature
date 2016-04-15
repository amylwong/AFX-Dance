Feature: Conflicts
  As a Director
  I want for each dancer to be picked a maximum of two times
  So that there are no dancer conflicts
  
Background:
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | casting_group_id | name     | email           | phone        | year    | gender  | conflicted |
     |                  | Dancer1  | test@test.com   | 999-999-9999 | 4       | Male    | true       |
    
  Given the following teams exist:
     |id  | name     | project | locked  | maximum_picks |
     | 1  | team1    | true    | false   | 40            |
     
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
     | t1@example.com     | password  | password              | training    |         |
     | t2@example.com     | password  | password              | training    |         |
  
Scenario: Dancer1 has been picked by more than two teams
  Given I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I should see "Dancer1"
  Then I follow "Add to my Team"
  Then I follow "Teams"
  Then I follow "View"
  Then I follow "Toggle Team Lock"
  Then I should see "There are dancer conflicts"
  