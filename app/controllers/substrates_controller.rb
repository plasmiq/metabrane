class SubstratesController < ApplicationController

  def update
    @substrate = Substrate.find( params[:id] )
    url = params[:substrate][:url]
    @substrate.picture_from_url( url )
    @substrate.url = url
    @substrate.save
    
    @wp = WorkingPair.find(params[:weave_id])
    @wp.status = WorkingPair::TWEAKED
    @wp.save
    
    @home_id = params[:home_id] || @wp.id
    
    respond_to do |format|  
      format.html
      format.js   { render :template => "weaves/update" }
    end  
  end
end
