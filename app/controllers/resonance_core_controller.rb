class ResonanceCoreController < ApplicationController
  skip_before_filter :authentication_check

  def bind
    render :text => Substrate.order('RAND()').first.image.url(:poster)
  end
end
