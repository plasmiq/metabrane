module WeavesHelper
  def weave_timestamp weave 
    timeago = " " + time_ago_in_words( weave.updated_at ) + " ago"
    content_tag :span, 
      content_tag( :span, weave.status_name, :class => "status" )  + timeago
  end 
end
