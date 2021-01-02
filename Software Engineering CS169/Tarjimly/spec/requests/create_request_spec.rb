require 'spec_helper.rb'
require 'rails_helper'

# RSpec.describe RequestsController, :type => :controller do 
describe "Navigating to a new request " do 
  it "should find the new request button" do
      visit "/requests"
      click_button 'New Request'
      expect(page).to have_current_path('/requests/new')          
  end
end

describe "Creating a new request" do
  before(:each) do 
    visit "/requests/new"
  end

  it "should render the response template" do
    get "/requests/new"
    expect(response).to render_template(:new)
  end


  it "should be able to fill in fields succcessfully" do
    within("#new_request") do
      fill_in 'request_title', with: 'Rspec Test'
      fill_in 'request_description', with: 'Rspec Test Description'
      fill_in 'request_document', with: 'Rspec Test Document'
      fill_in 'request_deadline', with: '2097-08-08'
      select 'English', from: 'request_from_language'
      select 'Arabic', from: 'request_to_language'
    end
    click_button 'Create Request'
    expect(page).to have_current_path('/requests')
  end

  it "should fail" do
    within("#new_request") do
      fill_in 'request_title', with: 'Rspec Test'
    end
    click_button 'Create Request'
    expect(page).to have_current_path('/requests/new')
  end
end

# describe RequestsController, type: :controller do
#   it "should redirect after failing" do
#     expect {
#       post :create, params: {request: {nil}}
#     }.should redirect_to("/requests/new")
#   end
# end

    