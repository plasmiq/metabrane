module MetacodesHelper
  def metacodes_list substrate
    html = ""
    Metacode.list.each do |name|
      metacode = Metacode.find_by_name name
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
