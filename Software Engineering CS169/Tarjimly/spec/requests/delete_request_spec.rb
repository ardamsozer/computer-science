require 'spec_helper.rb'
require 'rails_helper'

describe 'Users are able to delete their requests' do 
    before(:each) do 
        @request = Request.create(from_language: 'English', to_language: 'Arabic', description: 'information regarding upcoming doctors appointment',  title: 'Doctor Appointment', document: 'pdf', deadline: '2019-05-05', user_tarjimly_id: 1, _status: 1)
    end
    
    it 'user requests page should display all submitted requests' do
        visit "/requests"
        click_link("Completed Translations")
        expect(page).to have_text("Doctor Appointment")
    end 
    it 'should have a delete button' do
        visit "/requests/1"
        page.should have_selector(:link_or_button, 'Delete Request')
    end 
    it  'deleting request should redirect back to index page' do 
        visit "/requests/1"
        click_button("Delete Request")
        expect(page.current_path).to eq "/requests"
    end 
    it 'display flash message confirming deltion' do 
        visit "/requests/1"
        click_button("Delete Request")
        expect(page).to have_text("Your request 'Doctor Appointment' has been deleted!")
    end 
    it 'after refreshing page, request should be gone' do 
        visit "/requests/1"
        click_button("Delete Request")
        visit "/requests"
        expect(page).to have_no_content("Doctor Appointment")
    end 
end 

