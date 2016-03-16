Feature: General Site
  As a user
  So that I can learn about the organization
  I want to be able to view the main site
  
Scenario: Main Page Navigation
  Given I am on the home page
  Then I should see "AFX"
  And I should see "Home"
  And I should see "Auditions"
  Then I follow "Auditions"
  Then I should see "Board Login"
  Then I follow "Board Login"
  Then I should be on the Admin Login Page