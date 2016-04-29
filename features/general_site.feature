Feature: General Site
  As a user
  So that I can learn about the organization
  I want to be able to view the main site

Scenario: Main Page Navigation
  Given I am on the home page
  Then I should see "AFX AUDITION SITE"
  And I should see "About"
  And I should see "Admin Login"
  And I should see "Signup Form"
  And I follow "Admin Login"
  Then I should be on the Admin Login Page