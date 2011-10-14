class SubstratesController < ApplicationController

  def update
    @substrate = Substrate.find( params[:id] )
    @wp = WorkingPair.find(params[:weave_id])
    url = params[:substrate][:url]
    if url != @substrate_url
      @substrate.picture_from_url( url )
      @substrate.url = url
      @substrate.save
      @wp.status = WorkingPair::TWEAKED
      @wp.save
    end
    
    @home_id = params[:home_id] || @wp.id
    
    respond_to do |format|  
      format.html
      format.js   { render :template => "weaves/update" }
    end  
  end
  
  def zoom
    @substrate = Substrate.find( params[:id] )
    render :layout => false
  end
  
  def update_metacode
    @substrate = Substrate.find( params[:id] )
    metacode = params[:metacode]
    unless metacode.empty?
      @substrate.metacode = metacode
      @substrate.save
    end
    respond_to do |format|
      format.js   { render :nothing => true }
    end  
  end
end
