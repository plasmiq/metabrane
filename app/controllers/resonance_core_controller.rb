class ResonanceCoreController < ApplicationController
  def bind
    render :text => Substrate.order('RAND()').first.image.url(:poster)
  end
end
