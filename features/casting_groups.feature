Feature: Casting Groups
  As a Director
  So that I can view my dancer's casting videos
  I want to be able to view the casting groups
  
Background: the admin page has some content
  
  Given I am on the Admin Login Page
  Given the following admins exist:
   | email              | password  | password_confirmation | admin_type|
   | admin@example.com  | password  | password              | admin     |   
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Audition Form"
  And I should see "AFX AUDITIONS"
  And I fill in "dancer[name]" with "Dancer1"                    
  And I select "4" from "dancer[year]"
  And I select "Male" from "dancer[gender]"                   
  And I fill in "dancer[email]" with "email@email.com"           
  And I fill in "dancer[phone]" with "999-999-9999"              
  Then I press "I'm ready to audition!"                          
  Given I am on the Admin Page                                   
  Then I follow "Logout"  

Scenario: As an admin, I should be able to create casting groups
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Casting Groups"
  Then I follow "New Casting Group"
  Then I fill in "Video" with "https://www.youtube.com/"
  Then I fill in "Members" with "1"
  Then I press "Create Casting group"
  Then I should see "Casting group #1"
  Then I should see "https://www.youtube.com/"


Scenario: As an admin, I should be able to see what casting group a dancer is in.
  Given I log in as "admin@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Casting Groups"
  Then I follow "New Casting Group"
  Then I fill in "Video" with "https://www.youtube.com/"
  Then I fill in "Members" with "1"
  Then I press "Create Casting group"
  Then I follow "Dancers"
  Then I follow "View"
  Then I should see "Casting group #1"
  Then I follow "Casting group #1"
  Then I should see "Video"

@wip
Scenario: I should see all casting groups as an Admin