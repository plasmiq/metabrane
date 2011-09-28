class WorkingPair < ActiveRecord::Base
  belongs_to :substrate1,:class_name => "Substrate", :foreign_key => "substrate1_id"
  belongs_to :substrate2,:class_name => "Substrate", :foreign_key => "substrate2_id"
  
  def object1
    substrate1 ? substrate1.image : image1_url
  end
  
  def object2
    substrate1 ? substrate2.image : image2_url
  end
end
