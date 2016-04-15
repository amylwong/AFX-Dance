Feature: Conflicts
  As a Director
  I want for each dancer to be picked a maximum of two times
  So that there are no dancer conflicts
  
Background:
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | name     | year    | gender | email           | phone        |conflicted | team_id   |
     | Dancer1  | 4       | M      | test@test.com   | 999-999-9999 |true       | [1, 2, 3] |
     | Dancer2  | 4       | F      | ex@ex.com       | 888-888-8888 |false       | 1        |
  Given the following teams exist:
     |id  | name     | project | locked  | maximum_picks |
     | 1  | team1    | true    | false   | 40            |
     | 2  | team2    | false   | false   | 15            |
     | 3  | team3    | false   | false   | 15            |
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
     | t1@example.com     | password  | password              | training    | 2       |
     | t2@example.com     | password  | password              | training    | 3       |
  
Scenario: Dancer1 has been picked by more than two teams
  Given I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Teams"
  Then I follow 
  