class ResonanceCoreController < ApplicationController
  skip_before_filter :authentication_check

  def bind
    substrate = Substrate.order('RAND()').first
    url = substrate.image.url(:ultra_poster)
    #NodeDeposit.create
    #  :session => params["user_session_id"],
    #  :pivot => params["click_area"]
    render :text => {:url => "http://" + request.host_with_port + url}.to_json
  end
end
