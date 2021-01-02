require 'rails_helper'
require 'rails_helper'


describe Request do 
    it 'should have many claims' do
        expect(Request.reflect_on_association(:claims).macro).to be (:has_many)
    end
end


