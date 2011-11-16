require "open-uri"


class Substrate < ActiveRecord::Base
  has_many :working_pair
  
  has_attached_file :image,
    :styles => { 
      :poster => "316x332",
      :thumb => "62x72"
    }

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
