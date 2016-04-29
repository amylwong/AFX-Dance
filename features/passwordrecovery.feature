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
	And I follow "Forgot your password?"
	Then I fill in "admin_user[email]" with "admin@example.com"
	And I press "Reset My Password"
	Then I should see "You will receive an email with instructions on how to reset your password in a few minutes."

Scenario: Fake Email
	Given I am on the Admin Login Page
	And I follow "Forgot your password?"
	Then I fill in "admin_user[email]" with "fakeadmin@example.com"
	And I press "Reset My Password"
	Then I should see "error prohibited this admin user from being saved"