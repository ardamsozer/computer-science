require 'spec_helper.rb'
require 'rails_helper'

describe "User viewing their requests " do 
    # @AHMAD ADD PARAMATERS FOR THE FILTERING OF REQUESTS 
    it 'should be all to see pending requests' do
        get "/requests"
        expect(response).to render_template(:index)
    end
    #   @AHMAD ADD PARAMATERS FOR THE FILTERING OF REQUESTS PART 2
    it 'should be all completed requests' do
        get "/requests"
        expect(response).to render_template(:index)
    end
end