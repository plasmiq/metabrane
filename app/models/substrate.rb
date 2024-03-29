require "open-uri"


class Substrate < ActiveRecord::Base
  has_many :working_pair
  
  has_attached_file :image,
    :styles => { 
      :poster => "316x332",
      :thumb => "62x72",
      :ultra_poster => "700x500>"
    }
      
  class << self
    def random
      WorkingPair.random.substrates[ rand(2) ]
    end
  end
  
  def metatags 
    WorkingPair.with_substrate(self).map {|w| w.relation }
  end

  def picture_from_url(url)
    self.image = open(url)
  end
  
  def width
    Paperclip::Geometry.from_file(image).width.to_i
  end
  def height
    Paperclip::Geometry.from_file(image).height.to_i
  end

end
