module MetacodesHelper
  def metacodes_list
    html = ""
    21.times do |num|
      metacode = Metacode.new
      metacode.id = num 
      html += content_tag :a,
        "",
        :class => "metacode metacode#{metacode.id}",
        :title => metacode.name
    end
    raw html
  end
end
