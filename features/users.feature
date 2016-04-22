Feature: Users
  As an Admin
  I want to create new user accounts
  So that directors and board members can have accounts
  
Background:
  Given I am on the Admin Login Page
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type |
     | admin@example.com  | password  | password              | admin      |    
  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  
Scenario: New Board Members
  Given I follow "Admin Users"
  Then I follow "New Admin User"
  Then I fill in "Email" with "newboard@example.com"
  Then I fill in "Admin type" with "board"
  Then I fill in "Password*" with "password"
  Then I fill in "Password confirmation" with "password"
  Then I press "Create Admin user"
  Then I should see "Admin user was successfully created"
  Then I should see "board"
  
Scenario: New Project Team Director
  Given I follow "Admin Users"
  Then I follow "New Admin User"
  Then I fill in "Email" with "newproject@example.com"
  Then I fill in "Admin type" with "project"
  Then I fill in "Password*" with "password"
  Then I fill in "Password confirmation" with "password"
  Then I press "Create Admin user"
  Then I should see "Admin user was successfully created"
  Then I should see "project"
  
Scenario: New Training Team Director
  Given I follow "Admin Users"
  Then I follow "New Admin User"
  Then I fill in "Email" with "newtraining@example.com"
  Then I fill in "Admin type" with "training"
  Then I fill in "Password*" with "password"
  Then I fill in "Password confirmation" with "password"
  Then I press "Create Admin user"
  Then I should see "Admin user was successfully created"
  Then I should see "training"
  
Scenario: Wrong admin type (sad path)
  Given I follow "Admin Users"
  Then I follow "New Admin User"
  Then I fill in "Email" with "wrongtype@example.com"
  Then I fill in "Admin type" with "generic"
  Then I fill in "Password*" with "password"
  Then I fill in "Password confirmation" with "password"
  Then I press "Create Admin user"
  Then I should see "Must be either: admin, board, project or training."

Scenario: Invalid Email (sad path)
  Given I follow "Admin Users"
  Then I follow "New Admin User"
  Then I fill in "Email" with "bademail"
  Then I fill in "Admin type" with "board"
  Then I fill in "Password*" with "password"
  Then I fill in "Password confirmation" with "password"
  Then I press "Create Admin user"
  Then I should see "is invalid"