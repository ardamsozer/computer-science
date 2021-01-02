require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)


Given("I go to the {string} page") do |string|
    visit path_to(string)
  end

When ("I click the {string} button") do |string|
    click_button(string)
end 

When ("I select {string}") do |link|
  click_link(link)
end

When("I fill in {string} with {string}") do |field, value|
  fill_in(field, with: value)
end

# When("I fill in datefield {string} with {string}") do |field, value|
#   fill_in(field, with: "))
# end

When("I select {string} from {string}") do |value, field|
  select(value, from: field)
end

When("I check {string}") do |field|
  check(field)
end

When("I refesh the page") do
  visit current_path 
end
