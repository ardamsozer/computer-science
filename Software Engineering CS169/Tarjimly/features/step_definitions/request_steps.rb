Given /the following requests exist/ do |requests_table|
  requests_table.hashes.each do |r|
    Request.create(r)
  end
end

Then ("I should see {string}") do |string|
  # page.should have_content(string)
  expect(page).to have_content(string)
end

Then ("I should not see {string}") do |string|
  page.should have_no_content(string) 
end

Then ("I should see {string} and {string}") do |string, string1|
    page.should have_content(string) 
    page.should have_content(string1)
end

Then("I should be on the {string} path") do |page_path|
    begin
      expect(page).to have_current_path(page_path)
    rescue NoMethodError, ArgumentError
      raise "Can't find path for \"#{page_path}\" " 
    end
end

Then("I should see confirmation of deleting {string}") do |string|
  page.should have_content(string)
end

