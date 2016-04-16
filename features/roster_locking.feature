Feature: Roster Locking
  As a Project Team Director
  I want to lock my team if there are no conflicts
  So my team roster is finalized

Background: Teams and Director accounts are set up. 
  Given I am on the Admin Login Page
  Given the following dancers exist:
     | name     | year    | gender    | email            | phone        | conflicted |
     | Dancer1  | 4       | Male      | test1@test.com   | 111-111-1111 |            |
     | Dancer2  | 4       | Male      | test2@test.com   | 222-222-2222 |            |
     | Dancer3  | 4       | Male      | test3@test.com   | 333-333-3333 |            |  
     | Dancer4  | 4       | Male      | test4@test.com   | 444-444-4444 |            |
  Given the following teams exist:
     | name           | project | locked | 
     | Project1       | true    |        |            
     | Project2       | true    |        |            
     | Project3       | true    | true   |       
     | Training1      | false   |        |            
  
  Given the following admins exist:
     | email                | password  | password_confirmation | admin_type| team_id   |
     | admin@example.com    | password  | password              | admin     |           |
     | project@example.com  | password  | password              | project   | 1         |
     | project2@example.com | password  | password              | project   | 2         |
     | project3@example.com | password  | password              | project   | 3         |
     | training@example.com | password  | password              | training  | 4         |

  Given the following dancers_teams exist:
    | dancer_id   | team_id    |
    | 3           | [1 ,2, 3]  |

@wip
Scenario: Training teams can't add dancers before project teams have locked their rosters

	Given I log in as "training@example.com" with password "password"
	Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Dancers"
  Then I should be on the Dancer Page
  When I check "batch_action_item_1"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Then I should see "You cannot pick right now, project teams are still picking"
	
  
Scenario: Teams can lock rosters with no conflicts	
  Given I log in as "project@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Teams"
  Then I follow "View" for team "team_1"
  And I follow "Toggle Team Lock"
  Then I should see "Project1 has been locked"
  
Scenario: Teams cannot lock rosters with conflicts
  Given I log in as "project2@example.com" with password "password"
  Then I should be on the Admin Page
  And I should see "Signed in successfully."
  Then I follow "Teams"
  Then I follow "View" for team "team_2"
  And I follow "Toggle Team Lock"
  Then I should see ""
  
Scenario:  Teams cannot add or remove dancers when their roster is locked
  Given I log in as "project3@example.com" with password "password"
  Then I should be on the Admin Page
  Then I follow "Dancers"
  Then I should be on the Dancer Page
  Then I follow "Remove from Team" for dancer "dancer_1"
  Then I should see ""

@wip 
Scenario: Conflicts: There is a conflict on a dancer if more than 2 teams have added the dancer to their team.
  Given I log in as "project@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer1"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Given I am on the Admin Page                                   
  Then I follow "Logout" 
  Given I log in as "project2@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer1"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Given I am on the Admin Page                                   
  Then I follow "Logout" 
  Given I log in as "project3@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer1"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Then I select "Yes" from "q[conflicted_eq]"
  And I press "Filter"
  Then I should see "Dancer1"

@wip
Scenario: Randomization: If a dancer does not have a team, assign the dancer to a random team.
  Given I log in as "project@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer1"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Then I follow "Teams"
  Then I follow "View" for team "team_1"
  And I follow "Toggle Team Lock"                             
  Then I follow "Logout" 
  
  Given I log in as "project2@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer2"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Then I follow "Teams"
  Then I follow "View" for team "team_2"
  And I follow "Toggle Team Lock"                             
  Then I follow "Logout"                               
  
  Given I log in as "project3@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer3"
  Then I follow "Batch Actions"
  Then I follow "Add To My Team Selected"
  Then I follow "Teams"
  Then I follow "View" for team "team_3"
  And I follow "Toggle Team Lock"                             
  Then I follow "Logout"                                 
  
  Given I log in as "training@example.com" with password "password"
  Then I should be on the Admin Page
  When I follow "Dancers"
  Then I should be on the Dancer Page
  When I select a dancer "Dancer4"
  Then I follow "Batch Actions"
  Then I should see "Final Randomization Selected"
  Then I follow "Final Randomization Selected"
  Then I follow "View" for dancer "dancer_4"
  And I should see "Training1"
  