module MenuHelper

  def menu_element id, text, url
    cl = ""
    cl = "selected" if current_page?(url) 
    content_tag :a, content_tag(:span,text), :id => id, :href => url_for(url), :class => cl
  end
end
