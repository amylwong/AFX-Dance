Feature: Conflicts
  As a Director
  I want for each dancer to be picked a maximum of 2 times
  So that there are no dancer conflicts
  
Background:
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | name     | year    | gender | email           | phone        |conflicted |
     | Dancer1  | 4       | M      | test@test.com   | 999-999-9999 |false      |
     | Dancer2  | 4       | F      | ex@ex.com       | 888-888-8888 |true       |
  Given the following teams exist:
     | name     | project | locked  | maximum_picks |
     | team1    | true    | false   | 40            |
     | team2    | false   | false   | 15            |
     | team3    | false   | false   | 15            |
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type |
     | admin@example.com  | password  | password              | admin      |    
  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."