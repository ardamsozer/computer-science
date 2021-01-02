require 'spec_helper.rb'
require 'rails_helper'

describe "User viewing details for a specific request" do 
    before(:each) do 
        @request = Request.create(from_language: 'English', to_language: 'Arabic', description: 'information regarding upcoming doctors appointment',  title: 'Doctor Appointment', document: 'pdf', deadline: '2019-05-05', user_tarjimly_id: 1)
    end
    it 'should be all submitted translations' do
        get "/requests"
        expect(response).to render_template(:index)
    end
    it 'should be to see details for specific request' do
        get '/requests/1'
        expect(response).to render_template(:show)
    end

    it 'should be able to return back too all requests' do 
        visit "/requests/1"
        page.should have_selector(:link_or_button, 'All Requests')
    end

    it 'clicking all requests wil redirect to index page' do 
        visit "/requests/1"
        click_button("All Requests")
        expect(page.current_path).to eq "/requests"
    end 

    it 'should have infotmation about the specifics of the request' do 
        visit "/requests/1"
        expect(page).to have_content("Request Language: English")
        expect(page).to have_content("Translation Language: Arabic")
        expect(page).to have_content("information regarding upcoming doctors appointment")
    end
   
end