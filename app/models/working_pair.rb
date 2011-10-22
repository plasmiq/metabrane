class WorkingPair < ActiveRecord::Base
  belongs_to :substrate1,:class_name => "Substrate", :foreign_key => "substrate1_id"
  belongs_to :substrate2,:class_name => "Substrate", :foreign_key => "substrate2_id"
  
  scope :recent, order("working_pairs.updated_at DESC")
  scope :favorited, 
    lambda { includes(:favorites).where("favorites.working_pair_id = working_pairs.id") }
  
  has_many :favorites
  
  validates :relation, :presence => true
  
  
  CREATED    = 1
  EXTENDED   = 2
  TWEAKED    = 3


  STATUSES = {
    CREATED   => 'created',
    EXTENDED  => 'extended',
    TWEAKED   => 'tweaked'
  }

  # just a helper method for the view
  def status_name
    STATUSES[status]
  end
  
  def favorite?
    favorites.count > 0
  end
  
  def entangeled_weaves
    cond = "((substrate1_id = ?) and (substrate2_id = ?)) or ((substrate1_id = ?) and (substrate2_id = ?))"
    
    WorkingPair.where( cond, self.substrate1_id_before_type_cast, self.substrate2_id, self.substrate2_id, self.substrate1_id ).order("updated_at DESC")
  end
  
  def entangled
    WorkingPair.where( "relation = ?", relation )
  end
  
  def older 
    entangled.where( "updated_at < ?",updated_at ).order("updated_at DESC")
  end
  
  def newer
    entangled.where( "updated_at > ?",updated_at ).order("updated_at ASC")
  end
end
