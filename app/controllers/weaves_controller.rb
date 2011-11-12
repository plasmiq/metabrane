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
      redirect_to '/'
    else 
      render :new
    end
  end
  
  def show
    id = params[:id].to_i
    @wp = WorkingPair.find(id)
    @home = @wp
    @direction = 0
        
    home_id = params[:home_id].to_i
    @home = WorkingPair.find( home_id ) if home_id > 0
    @container_id = params[:container_id] || @home.id
        
        
    if params[:direction]    
      @direction = params[:direction].to_i
      unless @direction == 0
        if -1*@direction - 1 >= 0
          @wp = @home.older.offset(-1*@direction - 1).first    
        else
          @wp = @home.newer.offset(@direction - 1).first    
        end
      else
        @wp = @home
      end
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
  end
  
  def index 
    @page = params[:page] || 1
    @per_page = 4
    @weaves = WorkingPair.recent.paginate(:page => @page, :per_page => @per_page, :group => "substrate1_id, substrate2_id")
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
    old = WorkingPair.find(params[:id])
    @wp = WorkingPair.new
    @wp.substrate1 = old.substrate1
    @wp.substrate2 = old.substrate2
    
    @wp.relation = params[:working_pair][:relation]
     
    unless old.relation == @wp.relation
      #old.status = WorkingPair::TWEAKED
      #old.save
      
      @wp.save
    else 
      @wp = old
    end
     
    home_id = params[:working_pair][:home_id] || old.id
    @home = WorkingPair.find_by_id(home_id)
    
    respond_to do |format|  
      format.html { redirect_to( :action => :show, :id => @wp.id ) }  
      format.js   
    end  
  end
end
