Feature: Working Admin Page
  As an admin
  So that I can navigate the site
  I want to be able to view the admin page
  
Background: the admin page has some content
  
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | id | name     | year    | gender | email           | phone        |
     | 1  | Dancer1  | 4       | M      | test@test.com   | 999-999-9999 | 
  
Scenario: I should be able to log in successfully as an Admin
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  
Scenario: I should fail log in with incorrect information
  Given I log in as "admin@example.com" with password "passwordWRONG"
  Then I should be on the Admin Login Page
  And I should see "Invalid email or password."
  
Scenario: I should be able to see Audition Form as an Admin
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Audition Form"
  And I should see "Audition Form"
  And I fill in "dancer[name]" with "Name"
  And I fill in "dancer[year]" with "4"
  And I fill in "dancer[gender]" with "M"
  And I fill in "dancer[email]" with "email@email.com"
  And I fill in "dancer[phone]" with "999-999-9999"
  Then I press "SUBMIT"
  Then I should see "Your audition number is"

Scenario: I should see registered dancers as an Admin
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "All Dancers"
  And I should see "Dancer1"
  Then I follow "Dancer1"
  And I should see "Auditionee Profile"
  And I should see "Audition Number: 1"
  
Scenario: I should search dancers as an Admin
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Search"
  Then I fill in "name" with "Dancer1"
  Then I press "Search"
  Then I should see "Dancer1"
  Then I follow "Dancer1"
  Then I should see "Audition Number: 1"