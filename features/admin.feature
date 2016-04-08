Feature: Working Admin Page
  As an admin
  So that I can navigate the site
  I want to be able to view the admin page
  
Background: the admin page has some content
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | name     | year    | gender | email           | phone        |
     | Dancer1  | 4       | M      | test@test.com   | 999-999-9999 |
  Given the following teams exist:
     | name     | project |
     | Hi       | false   |
  
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
  And I should see "AFX AUDITIONS"                               
  And I fill in "dancer[name]" with "Name"   
  And I select "4" from "dancer[year]"
  And I select "Male" from "dancer[gender]"
  And I fill in "dancer[email]" with "email@email.com"           
  And I fill in "dancer[phone]" with "999-999-9999"              
  Then I press "I'm ready to audition!"                          
  Then I should see "Your audition number is"                    

Scenario: I should see registered dancers as an Admin            
  Given I log in as "admin@example.com" with password "password" 
  Then I should be on the Admin Page                             
  And I should see "Signed in successfully."                     
  Then I follow "Dancers"                                        
  And I should see "Dancer1"                                     
  Then I follow "View"                                           
  And I should see "Dancer Details"                              
  And I should see "Gender Male"                                 

Scenario: I should search dancers as an Admin                    
  Given I log in as "admin@example.com" with password "password" 
  Then I should be on the Admin Page                             
  And I should see "Signed in successfully."                     
  Then I follow "Dancers"                                        
  Then I fill in "q_name" with "Dancer1"                         
  Then I press "Filter"                                          
  Then I should see "Dancer1"                                    
  Then I follow "View"                                           
  Then I should see "Gender Male"                                

Scenario: I search for a dancer that does not exist 
  Given I log in as "admin@example.com" with password "password" 
  Then I should be on the Admin Page                             
  And I should see "Signed in successfully."                     
  Then I follow "Dancers"                                        
  Then I fill in "q_name" with "NOTAREALDANCER"                  
  Then I press "Filter"                                          
  Then I should see "No Dancers found"                           

Scenario: As admin I should be able to make a training team      
  Given I log in as "admin@example.com" with password "password" 
  Then I should be on the Admin Page                             
  And I should see "Signed in successfully."                     
  Then I follow "Teams"                                          
  Then I follow "New Team"                                       
  Then I fill in "Name" with "Hi"                                
  Then I press "Create Team"                                     
  Then I should see "Hi"                                         
  Then I should see "Training Team"                              

Scenario: As admin I should be able to make a project team       
  Given I log in as "admin@example.com" with password "password" 
  Then I should be on the Admin Page                             
  And I should see "Signed in successfully."                     
  Then I follow "Teams"                                          
  Then I follow "New Team"                                       
  Then I fill in "Name" with "Bye"                               
  Then I check "team_project"                                    
  Then I press "Create Team"                                     
  Then I should see "Bye"                                        
  Then I should see "Project Team"              
  
@wip
Scenario: As an admin, I should be able to search through dancers on the Dancers page.
  