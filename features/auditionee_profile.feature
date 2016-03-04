Feature: display profile of auditionee
  
  As an executive
  So that I can find relevant information quickly
  I want every auditionee to have their own profile
  
Background: auditionees have been added to the database
  
  Given the following auditionees exist:
  | name        | year     | gender | email                    | phone      | audition_number | audition_video | selected_teams |
  | Michael Zhu | Freshman | Male   | michael.jx.zhu@gmail.com | 9095695596 | 1               | bit.ly/mzhu    | team1          |
  | Albert Weng | Freshman | Male   | albertweng@gmail.com     | 9254874849 | 2               | bit.ly/aweng   | team2          |
  | Alice Cai   | Freshman | Female | alicecai@lol.com         | 9099099009 | 3               | bit.ly/acai    | team3          |
  | Angela Peng | Freshman | Female | asdadada@lol.com         | 9099099009 | 4               | bit.ly/apeng   | team4          |
  | Amy Wong    | Freshman | Female | amywong@lol.com          | 9099099009 | 5               | bit.ly/awong   | team5          |
  | Calvin Chen | Senior   | Male   | calvinchen@berkeley.edu  | 9099099009 | 6               | bit.ly/cchen   | team6          |
  
  And I am on the profile page for "Albert Weng"
  
Scenario: profile information shows up
  
  Then I should see "Freshman"
  And I should see "Male"
  And I should see "albertweng@gmail.com"
  And I should see "9254874849"
  And I should see "bit.ly/aweng"
  And I should see "team2"