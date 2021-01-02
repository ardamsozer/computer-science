class RequestObserver < ActiveRecord::Observer
    # observe :_status
    def after_update(request)
        if request._status == 1
          #  sendy email api call to request's user_id email
        end
    end
end 