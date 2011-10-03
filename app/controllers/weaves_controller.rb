class WeavesController < ApplicationController
  def create
    @wp = WorkingPair.new(params[:working_pair])
    
    s1 = Substrate.new
    s1.picture_from_url(@wp.image1_url)
    s1.save
    s2 = Substrate.new
    s2.picture_from_url(@wp.image2_url)
    s2.save
   
    
    @wp.substrate1 = s1
    @wp.substrate2 = s2
    
    if @wp.save  
      redirect_to :action => :index
    else 
      render :new
    end
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
         
    respond_to do |format|  
      format.html
      format.js   
    end
  end
  
  def favorite
    @weavement_id = params[:id]
    @favorite = Favorite.find_or_initialize_by_working_pair_id( @weavement_id )
    if @favorite.new_record?
      @favorite.save
    else
      @favorite.destroy
    end
    respond_to do |format|  
      format.js   
    end
  end
  
  def index 
    @weaves = WorkingPair.recent
  end
  
  def favorites 
    @weaves = WorkingPair.favorited.recent
    render "index"
  end
  
  def destroy 
    @wp = WorkingPair.find( params[:id] )
    @wp.destroy
    
    respond_to do |format|  
      format.html { redirect_to(posts_url) }  
      format.js   { render :nothing => true }  
    end  
  end

end
