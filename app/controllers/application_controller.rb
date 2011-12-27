class ApplicationController < ActionController::Base
  protect_from_forgery
  
  USER, PASSWORD = 'metabrane', 'gen001'
 
  before_filter :authentication_check, :current_user
 
  def current_user 
    persona = cookies["persona"]
    if persona
      @current_user = persona
    else
      @current_user = "bad hacker and need to"
    end 
  end
 
  private
    def authentication_check
      authenticate_or_request_with_http_basic do |user, password|
        user == USER && password == PASSWORD
      end
    end
end
