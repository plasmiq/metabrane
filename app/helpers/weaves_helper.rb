module WeavesHelper
  def weave_remote_link text, target, options = {}
    home_id = options[:home].id if options[:home] 
    container_id = options[:container].id if options[:container]
    link_to content_tag(:span, text),
      { 
        :controller => :weaves, 
        :action => :show, 
        :id => target.id,
        :direction => options[:direction], 
        :home_id => home_id,
        :container_id => container_id
      },
      :remote => true,
      :class => "live_update "+options[:html_class],
      "data-preview_url" => options["data-preview_url"]
  end
  
  def weave_timestamp weave 
    timeago = ' ' + time_ago_in_words( weave.updated_at ) + ' ago'
    status = weave.status_name
    status = 'created' #TODO: remove in future
    content_tag :span, 
      content_tag( :span, status, :class => "status" )  + timeago,
      :class => "info"
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
