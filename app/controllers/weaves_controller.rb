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
    id = params[:id].to_i
    @wp = WorkingPair.find(id)
    @home = @wp
        
    home_id = params[:home_id].to_i
    @home = WorkingPair.find( home_id ) if home_id > 0
        
    direction = params[:direction].to_i
    @wp = @wp.newer.first if direction == 1
    @wp = @wp.older.first if direction == -1
         
    @home_id = @home.id if @home
    
    #not show home if you are there already
    @home = nil if @wp == @home
   
    #respond_to do |format|  
    #  format.html { render :layout => false }  
    #  format.js   { render :layout => false }  
    #end 
    render :layout => false
  end

end
