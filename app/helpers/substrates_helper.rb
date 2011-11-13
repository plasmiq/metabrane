module SubstratesHelper
  def distance_from_home metatags, metatag, home
    dist = (- metatags.index(metatag) + metatags.index(home) )
    if dist > 0
      dist = "+"+dist.to_s 
    elsif dist == 0
      dist = raw('&nbsp;'+dist.to_s) 
    else
      dist = dist.to_s if dist < 0
    end
    dist
  end
end
