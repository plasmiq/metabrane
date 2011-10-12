module MetacodesHelper
  def metacodes_list
    html = ""
    21.times do |num|
      html += content_tag :a,
        "",
        :href => "#",
        :class => "metacode metacode#{Metacode.all[num]}",
        :title => "#{Metacode.all[num]}"
    end
    raw html
  end
end
