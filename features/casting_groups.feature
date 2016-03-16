Feature: Casting Groups
  As a Director
  So that I can view my dancer's casting videos
  I want to be able to view the casting groups
  
Background: the admin page has some content
  
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | id | name     | year    | gender | email           | phone        |
     | 1  | Dancer1  | 4       | M      | test@test.com   | 999-999-9999 |
  Given the following admins exist:
     | email             | password | password_confirmation |
     | admin@example.com | password | password              |
  Given the following casting_groups exist:
     | id | dancer_id  |
     | 1  | 1          |

Scenario: I should see all casting groups as an Admin
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Casting Groups"
  And I should see "Dancer IDs"
  And I should see "Name"
  And I should see "Casting Group #"
  Then I follow "1"
  And I should see "Dancer1"