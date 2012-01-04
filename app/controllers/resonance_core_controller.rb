class ResonanceCoreController < ApplicationController
  skip_before_filter :authentication_check

  before_filter :verify_params
 
  def bind
    pivot = params["click_area"].to_i
    
    substrate = Substrate.find_by_id params["substrate_id"]
    case pivot
    when 1..9
      substrate = Substrate.find_by_id params["substrate_id"]
    else
      substrate = Substrate.random
    end
    
    if substrate
      #NodeDeposit.create
      #  :session => params["user_session_id"],
      #  :pivot => pivot
      #  "substrate_id" => substrate.id
      
      url = substrate.image.url(:ultra_poster)     
      render :text => {:url => "http://" + request.host_with_port + url}.to_json
    else
      render :text => {:error => "something went wrong"}.to_json
    end
  end
  
private

  def verify_params 
    raise "invalid session id" unless params["user_session_id"]
    raise "click area not provided" unless params["click_area"]
  rescue => e
    render :text => {:error => "not this time lad..", :exception => e.inspect}.to_json
  end

end
