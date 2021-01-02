class ClaimsController < ActionController::Base
  def requests
    if params.has_key?(:from_language)
      @requests = Request.where(:from_language => params[:from_language].capitalize, :to_language => params[:to_language].capitalize)
    else
      @requests = Request.all
    end
    @requests = @requests.sort_by{ |r| [r.deadline, r.num_claims]} unless !params.has_key?(:sort_by_deadline)
  end

  def preview

  end


  end

  def show
    cid = params[:claim_id]
    @claim = Request.find(cid)
  end

  def delete
    @claim = Claim.find(params[:claim_id])
    @claim.destroy 
    flash[:notice] = "Your request '#{@claim.title}' has been deleted!"
    redirect_to claims_url
  end

  def complete

  end

end
