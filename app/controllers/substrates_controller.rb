class SubstratesController < ApplicationController

  def update
    @substrate = Substrate.find( params[:id] )
    url = params[:substrate][:url]
    @substrate.picture_from_url( url )
    @substrate.url = url
    @substrate.save
    
   # @wp = WorkingPair.find(params[:id])
   # @wp.status = WorkingPair::TWEAKED
   # @wp.save
  end
end
