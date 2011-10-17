module WeavesHelper
  def weave_timestamp weave 
    timeago = " " + time_ago_in_words( weave.updated_at ) + " ago"
    content_tag :span, 
      content_tag( :span, weave.status_name, :class => "status" )  + timeago
  end 
  
  def weave_fav_link weave
    link_to '', 
        {:controller => :weaves, :action => :favorite, :id => weave.id},
        :method =>  :post,
        :remote => true,
        :taget => '_blank',
        :class=> "favorite_weave favorite_#{weave.favorite?} favorite_#{weave.id}"
        
  end
end
