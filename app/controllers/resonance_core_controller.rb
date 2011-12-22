class ResonanceCoreController < ApplicationController
  skip_before_filter :authentication_check

  def bind
    render {:url => Substrate.order('RAND()').first.image.url(:poster)}.to_json
  end
end
