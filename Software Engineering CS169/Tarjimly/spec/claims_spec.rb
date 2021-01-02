require 'rails_helper'

describe Claim do 
    it 'should belong to a Request' do
        expect(Claim.reflect_on_association(:request).macro).to be (:belongs_to)
    end
end