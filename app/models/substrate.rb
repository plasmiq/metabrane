require "open-uri"

class Substrate < ActiveRecord::Base
  has_many :working_pair
  
  has_attached_file :image,
    :styles => { :poster => "229x" }

  def picture_from_url(url)
    self.image = open(url)
  end

end
