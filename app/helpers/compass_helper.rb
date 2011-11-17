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
    color = "grey" if ( weave and ( weave.id == home.id ) )
    css_class  = "button #{color}"
    css_class += " hidden" unless weave
    content_tag( :a, raw(html), :class => css_class, 
      "data-preview_url" => remote_options[:preview_url] )
  end
  
  def similarity_css(w1,w2)
    if (w1 == w2)
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
