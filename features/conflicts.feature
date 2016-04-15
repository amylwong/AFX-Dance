Feature: Conflicts
  As a Director
  I want to yoloswag
  So that each team is yoloswagged
  
Background:
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | name     | year    | gender | email           | phone        |
     | Dancer1  | 4       | M      | test@test.com   | 999-999-9999 |
     | Dancer2  | 4       | F      | ex@ex.com       | 888-888-8888 |
  Given the following teams exist:
     | name     | project |
     | team1    | false   |
     | team2    | false   |
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type |
     | admin@example.com  | password  | password              | admin      |    
  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."