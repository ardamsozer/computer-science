class RequestsController < ActionController::Base
    def index
        @user = 1
        status = params[:status] || 1
        @requests = Request.where(user_tarjimly_id: @user, _status: status)
    end


    
    def new
        @request = Request.new
    end
    
    def create
        #Obtain request object from params
        @request = Request.new(request_params)

        if @request.nil? || @request.from_language.nil? || @request.to_language.nil? || @request.description.nil? || @request.title.nil? || @request.document.nil? || @request.deadline.nil? 
          redirect_to new_request_url
          return
        end

        #Add in private fields
        @request.document_format = "text" #TODO: Should be conditional based on upload
        @request.user_tarjimly_id = 1 #TODO: Should be based on auth
        @request.num_claims = 0 #TODO: Should be daault in db
        @request._status = 0  #TODO: Should be daault in db

        if @request.save
          flash[:notice] = "Success!"
          redirect_to requests_url
        else
          flash[:notice] = "Uh Oh!"
        end 

    end

    def delete 
        @request = Request.find(params[:request_id])
        @request.destroy 
        flash[:notice] = "Your request '#{@request.title}' has been deleted!"
        redirect_to requests_url
    end

    private
    def request_params
        params.require(:request).permit(:from_language, :to_language, :deadline, :document, :document_format, :title, :description,:form_type, :categories => [])
    end
end
