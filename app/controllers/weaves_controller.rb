class WeavesController < ApplicationController
  def create
    @wp = WorkingPair.new(params[:working_pair])
    
    s1 = Substrate.find_or_initialize_by_url(@wp.image1_url)
    s1.picture_from_url(@wp.image1_url)
    s1.url = @wp.image1_url
    s1.save
    s2 = Substrate.find_or_initialize_by_url(@wp.image2_url)
    s2.picture_from_url(@wp.image2_url)
    s2.url = @wp.image2_url
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
  end
  
  def favorite
    @weavement_id = params[:id]
    @favorite = Favorite.find_or_initialize_by_working_pair_id( @weavement_id )
    if @favorite.new_record?
      @favorite.save
    else
      @favorite.destroy
    end
  end
  
  def index 
    @page = params[:page] || 1
    @per_page = 4
    @weaves = WorkingPair.recent.paginate(:page => @page, :per_page => @per_page)
  end
  
  def favorites 
    @weaves = WorkingPair.favorited.recent
    render "index"
  end
  
  def destroy 
    @wp = WorkingPair.find( params[:id] )
    @wp.destroy
    
    respond_to do |format|  
      format.html { redirect_to("") }  
      format.js   { render :nothing => true }  
    end  
  end

  def update
    @wp = WorkingPair.find(params[:id])
    @wp.relation = params[:working_pair][:relation]
    
    @home_id = params[:working_pair][:home_id] || @wp.id
    
    @wp.status = WorkingPair::TWEAKED
    @wp.save
    
    respond_to do |format|  
      format.html { redirect_to( :action => :show, :id => @wp.id ) }  
      format.js   
    end  
  end
end
