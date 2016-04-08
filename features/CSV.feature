Feature: CSV Thing

Background: Teams and Director accounts are set up, There are Dancers inside Project_Director.team()

@wip
Scenario: Testing CSV

	Given I am logged in as a Project_Director
	And I am leading the team "ProjectTeam"
	Then I go to the Dancers Page
	Then follow "CSV"
	Then I should get a download with the filename "dancers-ProjectTeam.csv"
	
@wip
Scenario: Testing XML

	Given I am logged in as a Project_Director
	And I am leading the team "ProjectTeam"
	Then I go to the Dancers Page
	Then follow "XML"
	Then I should get a download with the filename "dancers-ProjectTeam.xml"

@wip
Scenario: Testing JSON

	Given I am logged in as a Project_Director
	And I am leading the team "ProjectTeam"
	Then I go to the Dancers Page
	Then follow "JSON"
	Then I should get a download with the filename "dancers-ProjectTeam.json"

@wip
Scenario: CSV with empty team
	Given I am logged in as a Training_Director
	And I am leading the team "SadTeam"
	Then I go to the Dancers Page
	Then I follow CSV
	Then I should see "There are no dancers in your team"

@wip
Scenario: CSV without leading a team
	Given I am logged in as a Board_Member
	Then I go to the Dancers Page
	Then I follow CSV
	Then I should see "You are not leading a team"
