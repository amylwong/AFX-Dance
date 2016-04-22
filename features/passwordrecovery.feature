Feature: Password Recovery
	As an admin
	So that I can recover my password
	I want to be able to receive my password over email.

Background: Admin accounts exist
  Given the following admins exist:
     | email              | password  | password_confirmation | admin_type|
     | admin@example.com  | password  | password              | admin     |    

Scenario: I should be able to recover my password via email
	Given I am on the Admin Login Page
	And I follow "Forgot password"
	Then I fill in "email" with "admin@example.com"
	I should see "Password has been sent to email admin@example.com"

Scenario: Fake Email
	Given I am on the Admin Login Page
	And I follow "Forgot password"
	Then I fill in "email" with "fakeadmin@example.com"
	I should see "There is no account associated with this email. Please try again."