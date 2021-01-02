class ClaimObserver < ActiveRecord::Observer
    observe :request
    def after_edit
        # update changes
        # so that I don't forget to complete a claimed request by the deadline
        # I want to receive an email reminder 24 hours in advance with a link to the claim
    end
end 