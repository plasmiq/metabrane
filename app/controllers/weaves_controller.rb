class WeavesController < ApplicationController
  def create
    wp = WorkingPair.new(params[:working_pair])
    
    s1 = Substrate.new
    s1.picture_from_url(wp.image1_url)
    s1.save
    s2 = Substrate.new
    s2.picture_from_url(wp.image2_url)
    s2.save
    
    wp.substrate1 = s1
    wp.substrate2 = s2
    
    wp.save  
    redirect_to :controller => :timeline
  end
  
  def show
    @wp = WorkingPair.find(params[:id].to_i + params[:direction].to_i)
    
    #respond_to do |format|  
    #  format.html { render :layout => false }  
    #  format.js   { render :layout => false }  
    #end 
    render :layout => false
  end

end
