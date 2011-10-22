module WeavesHelper
  def weave_timestamp weave 
    timeago = " " + time_ago_in_words( weave.updated_at ) + " ago"
    content_tag :span, 
      content_tag( :span, weave.status_name, :class => "status" )  + timeago
  end 
  
  def weave_options_tag weave, options = {}
    html = weave_timestamp(weave)
    toggles = ""
    toggles += weave_delete_link(weave) if options[:delete]
    toggles += weave_fav_link(weave) if options[:fav]
    toggles += weave_permalink(weave) if options[:permalink]
    html += content_tag :div, raw(toggles), :class => "toggles"

    content_tag( :div, raw(html), :class => "timestamp")
  end
  
  def weave_fav_link weave
    link_to '', 
        {:controller => :weaves, :action => :favorite, :id => weave.id},
        :method =>  :post,
        :remote => true,
        :taget => '_blank',
        :class=> "favorite_weave favorite_#{weave.favorite?} favorite_#{weave.id}"      
  end
  
  def weave_permalink weave
    link_to '', 
        {:controller => :weaves, :action => :show, :id => weave.id},
        :taget => "_blank",
        :class=>'permalink_weave' 
  end
  
  def weave_delete_link weave 
    link_to '', 
        {:controller => :weaves, :action => :destroy, :id => weave.id}, 
        :confirm => 'Are you sure?', 
        :method => :delete, 
        :remote=> true, 
        :class=>'delete_weave'
  end
end
