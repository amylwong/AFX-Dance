Feature: Conflicts
  As a Director
  I want to yoloswag
  So that each team is yoloswagged
  
Background:
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | casting_group_id | name      | email         | phone           | year  | gender        | conflicted  | id  |
     |                  | Dancer1   | test@test.com | 999-999-9999    | 4     | Male          | true        | 1   |

  Given the following teams exist:
     | project  | name      | locked  | maximum_picks | id |
     | true     | project1  | false   | 40            | 1  |

  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     | 1       |
  
  Given the following dancers_teams exist:
    | team_id | dancer_id |
    | 1       | 1         |
  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Logout" 
  
Scenario: Locking roster with conflicted dancers
  Given I am on the Admin Login Page
  Then I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I check2 "1"
  Then I follow "Batch Actions"
  Then I should see "Add To My Team Selected"
  Then I follow2 "Add To My Team Selected"
  Then I should see "added to your team"
  Then I follow "Teams"
  Then I follow "View"
  Then I should see "Dancer1"
  Then I follow "Toggle Team Lock"
  Then I should see "There are dancer conflicts"