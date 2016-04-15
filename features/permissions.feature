Feature: Permissions
  As an Admin
  I want for all other accounts to have limited permissions
  So that there will be better security
  
Background: Users of all admin_type exist
    Given the following admins exist:
     | email              | password  | password_confirmation | admin_type  | team_id |
     | admin@example.com  | password  | password              | admin       |         |
     | p@example.com      | password  | password              | project     |         |
     | t@example.com     | password  | password              | training     |         |
     | b@example.com     | password  | password              | board        |         |


Scenario: Permissions for training
  Given I log in as "t@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I should not see "New Dancer"
  Then I follow "Teams"
  Then I should not see "New Team"
  Then I follow "Admin Users"
  Then I should not see "New Admin User"
  Then I follow "Casting Groups"
  Then I should not see "New Casting Group"
  
Scenario: Permissions for project team director
  Given I log in as "p@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I should not see "New Dancer"
  Then I follow "Teams"
  Then I should not see "New Team"
  Then I follow "Admin Users"
  Then I should not see "New Admin User"
  Then I follow "Casting Groups"
  Then I should not see "New Casting Group"
  
Scenario: Permissions for board member
  Given I log in as "b@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I should see "New Dancer"
  Then I follow "Teams"
  Then I should see "New Team"
  Then I follow "Admin Users"
  Then I should see "New Admin User"
  Then I follow "Casting Groups"
  Then I should see "New Casting Group"
  
Scenario: Permissions for admin member
  Given I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully"
  Then I follow "Dancers"
  Then I should see "New Dancer"
  Then I follow "Teams"
  Then I should see "New Team"
  Then I follow "Admin Users"
  Then I should see "New Admin User"
  Then I follow "Casting Groups"
  Then I should see "New Casting Group"
  
