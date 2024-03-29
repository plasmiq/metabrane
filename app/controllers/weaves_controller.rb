require 'RMagick'

class WeavesController < ApplicationController
  def create
    @wp = WorkingPair.new(params[:working_pair])
    
    #s1 = Substrate.find_or_initialize_by_url(@wp.image1_url)
    s1 = Substrate.new 
    s1.picture_from_url(@wp.image1_url)
    s1.url = @wp.image1_url
    s1.save
    s2 = Substrate.new
    #s2 = Substrate.find_or_initialize_by_url(@wp.image2_url)
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

  def image
    id = params[:id].to_i
    @wp = WorkingPair.find(id)

    canvas = Magick::Image.new(662, 400){ self.background_color = '#212121' }
    img1 = Magick::Image.read( @wp.substrate1.image.path( :poster ) ).first
    img2 = Magick::Image.read( @wp.substrate2.image.path( :poster ) ).first
    gc = Magick::Draw.new
    gc.fill('white')
    gc.font = ("lib/fonts/FePIrm27C.otf")
    gc.pointsize = 30.0
    
    gc.text_align(Magick::CenterAlign)
    gc.text(331, 385, @wp.relation)
    
    canvas.composite!(img1, 10+(316-img1.columns)/2, 10+(332-img1.rows)/2, Magick::OverCompositeOp)
    canvas.composite!(img2, 336+(316-img2.columns)/2, 10+(332-img2.rows)/2, Magick::OverCompositeOp)

    gc.draw(canvas)
    canvas.format = 'png'
    
    render :text => canvas.to_blob, :status => 200, :content_type => 'image/png'
  end
  
  def show
    id = params[:id].to_i
    @wp = WorkingPair.find(id)
    @home = @wp
    @direction = 0
        
    home_id = params[:home_id].to_i
    @home = WorkingPair.find( home_id ) if home_id > 0
    @container_id = params[:container_id] || @home.id
    #show open graph API preview
    @ogimage = true

    @title = @home.relation
        
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
    weaves = WorkingPair
      .group_substrates
      .newest
      .paginate(:page => @page, :per_page => @per_page)
    @weaves = weaves.map do |w| 
      if params[:order] == "oldest"
        WorkingPair.same_substrates(w.substrate1, w.substrate2).oldest
      else
        WorkingPair.same_substrates(w.substrate1, w.substrate2).newest
      end.first
    end
  end
  
  def favorites 
    @weaves = WorkingPair.favorited.newest
    render "index"
  end
  
  def preview
    @wp = WorkingPair.find( params[:id] )
    render :layout => false
  end
  
  def destroy 
    @wp = WorkingPair.find( params[:id] )
    @wp.destroy
    
    respond_to do |format|  
      format.html { redirect_to("") }  
      format.js   { render :nothing => true }  
    end  
  end
  
  def search
    @search_phrase = params["search_phrase"]
    @order = params[:order] || "newest"
    @page = params[:page] ? params[:page].to_i : 1
    weaves = if @order == "newest"
      WorkingPair.newest
    else
      WorkingPair.oldest
    end
      .where(["relation LIKE :relation", {:relation => @search_phrase}]) 
      .paginate(:page => @page, :per_page => 1)
    @count = WorkingPair
      .where(["relation LIKE :relation", {:relation => @search_phrase}]) 
      .count
      
    @weave = weaves.first
  end
  
  def random 
    @weave = WorkingPair.offset( rand(WorkingPair.count) ).first
    redirect_to( :action => :show, :id => @weave.id )
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
    @direction = 0
    respond_to do |format|  
      format.html { redirect_to( :action => :show, :id => @wp.id ) }  
      format.js   
    end  
  end
end
