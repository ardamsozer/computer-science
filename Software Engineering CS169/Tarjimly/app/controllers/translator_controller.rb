class TranslatorController < ApplicationController
  def requests
    @requests = Request.all
  end
end
