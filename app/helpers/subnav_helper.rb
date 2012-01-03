module SubnavHelper
  def distance_from_home metatags, metatag, home
    dist = (- metatags.index(metatag) + metatags.index(home) )
    format_distance dist
  end
  
  def format_distance dist
    if dist > 0
      dist = "+"+dist.to_s 
    elsif dist == 0
      dist = raw('&nbsp;'+dist.to_s) 
    else
      dist = dist.to_s if dist < 0
    end
  end
  
  def weave_potential_tag weave
    html =  content_tag( :div, 
      content_tag( :span, format_distance( -weave.older.all.size ) ), 
      :class => "older")
    html += content_tag( :div, 
      content_tag( :span, format_distance( weave.newer.all.size ) ), 
      :class => "newer")
    content_tag( :div, raw(html), :class => "potential")
  end
end
