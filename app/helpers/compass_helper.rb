module CompassHelper
  def compass_button( weave, reference, home, color )
    html =  "" 
    remote_options = {}
    if weave
      css_class = similarity_css(weave, reference)
      css_class = "current" if color.include?("current")
      html += content_tag( :span, "", :class => "similar #{css_class}" ) 
      remote_options[:preview_url] = preview_weave_path(weave)
    end
    color = "grey" if ( weave and color.include?("red") and ( weave.id == home.id ) )
    css_class  = "button #{color}"
    css_class += " hidden" unless weave
    
    if weave
      weave_remote_link raw(html), weave, { :html_class  => css_class, :container => home,
        "data-preview_url" => remote_options[:preview_url] }
    else
      content_tag( :a, raw(html), :class => css_class, 
        "data-preview_url" => remote_options[:preview_url] )
    end
  end
  
  def compass_connector(direction)
    direction = (direction.abs) > 2 ? 2 * (direction/direction.abs) : direction
    css_class = (direction) < 1 ? "past_#{direction.abs}" : "future_#{direction}"
    content_tag( :div, "", :class => "connector #{css_class}")
  end
  
  def similarity_css(w1,w2)
    if ( (w1 == w2) or
       ( w1.relation == w2.relation and
         w1.substrate1 == w2.substrate1 and
         w1.substrate2 == w2.substrate2  ) )     
      "same"
    elsif 
      ( w1.relation == w2.relation and
        w1.substrate1 == w2.substrate1 and
        w1.substrate2 != w2.substrate2 ) 
      "right_different"
    elsif 
      ( w1.relation == w2.relation and
        w1.substrate1 != w2.substrate1 and
        w1.substrate2 == w2.substrate2 ) 
      "left_different"  
    elsif 
      ( w1.relation == w2.relation and
        w1.substrate1 != w2.substrate1 and
        w1.substrate2 != w2.substrate2 ) 
      "both_different"
    elsif 
      ( w1.relation != w2.relation and
        w1.substrate1 == w2.substrate1 and
        w1.substrate2 == w2.substrate2 ) 
      "metatag_different"
    elsif 
      ( w1.relation != w2.relation and
        w1.substrate1 != w2.substrate1 and
        w1.substrate2 == w2.substrate2 ) 
      "right_same"
    elsif 
      ( w1.relation != w2.relation and
        w1.substrate1 == w2.substrate1 and
        w1.substrate2 != w2.substrate2 ) 
      "left_same"
    else
      "different"
    end
  end
end
