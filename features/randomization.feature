Feature: Randomization
  As a Director
  I want to place the remaining dancers into training teams
  So that each team is finalized

Background: 
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | name     | year    | gender  | email           | phone        |
     | Dancer1  | 4       | Male    | test@test.com   | 999-999-9999 |
     | Dancer2  | 4       | Female  | ex@ex.com       | 888-888-8888 |
  Given the following teams exist:
     | name     | project |
     | team1    | false   |
     | team2    | false   |
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type|
     | admin@example.com  | password  | password              | admin     |    
  
  Then I log in as "admin@example.com" with password "password"
  And I should see "Signed in successfully."
  Then I follow "Audition Form"
  And I should see "AFX AUDITIONS"
  And I fill in "dancer[name]" with "Dancer1"                    
  Then I press "I'm ready to audition!"  
  Given I am on the Admin Page                                   
  Then I follow "Logout"  

Scenario: If a dancer does not have a team, assign the dancer to a random team.
  Given I am logged in as a Training_Director
  When I go to the Dancers page
  And I filter by "Unassigned"
  Then I should see "Dancer1"
  Then I should see "Unassigned Dancers"
  When I press "Randomize"
  And I filter by "Unassigned"
  Then I should not see "Dancer1"


