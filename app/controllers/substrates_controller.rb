class SubstratesController < ApplicationController

  def update
    @substrate = Substrate.find params[:id]
    @wp = WorkingPair.find(params[:weave_id])
    @home = WorkingPair.find(params[:home_id]) || @wp
    
    url = params[:substrate][:url]
    if url != @substrate.url
      weave = WorkingPair.clone(@wp)
      
      substrate = Substrate.new
      substrate.picture_from_url( url )
      substrate.url = url
      substrate.save
      if weave.substrate1.id == @substrate.id
        weave.substrate1 = substrate
      else weave.substrate2.id == @substrate.id
        weave.substrate2 = substrate
      end
      #weave.status = WorkingPair::TWEAKED
      weave.save
      @wp = weave
    end
    
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
