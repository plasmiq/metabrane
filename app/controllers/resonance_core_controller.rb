class ResonanceCoreController < ApplicationController
  skip_before_filter :authentication_check

  def bind
    render :text => {:url => "http://" + request.host_with_port + Substrate.order('RAND()').first.image.url(:big)}.to_json
  end
end
