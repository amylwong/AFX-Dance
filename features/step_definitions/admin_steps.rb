Given /the following (.*) exist:$/ do |type, table|
  table.hashes.each do |element|
    if    type == "dancers"    then Dancer.create(element)
    end
  end
end

Given /^I am logged into the admin panel$/ do
  visit '/accounts/login'
  fill_in 'Email', :with => 'weee'
  fill_in 'Password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end

Given /I log in as "(.*?)" with password "(.*?)"$/ do |email, pass|
  visit '/admin/login'
  fill_in 'admin_user[email]', :with => email
  fill_in 'admin_user[password]', :with => pass
  click_button 'Login'
end