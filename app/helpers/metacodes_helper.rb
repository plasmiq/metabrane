module MetacodesHelper
  def metacodes_list substrate
    html = ""
    21.times do |num|
      metacode = Metacode.new
      metacode.id = num 
      selected = ""
      selected = "selected" if substrate.metacode == metacode.name 
      html += content_tag :a,
        "",
        :class => "metacode metacode#{metacode.id} #{selected}",
        :title => metacode.name,
        :alt => metacode.name
    end
    raw html
  end
end
