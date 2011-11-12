class WorkingPair < ActiveRecord::Base
  belongs_to :substrate1,:class_name => "Substrate", :foreign_key => "substrate1_id"
  belongs_to :substrate2,:class_name => "Substrate", :foreign_key => "substrate2_id"
  has_many :favorites
  
  validates :relation, :presence => true
  
  scope :recent, order("working_pairs.updated_at DESC")
  scope :favorited, lambda { 
    includes(:favorites)
    .where("favorites.working_pair_id = working_pairs.id") 
  }
  
  scope :same_substrates, lambda { |substrate1, substrate2|
    where( 
      "((substrate1_id = ?) and (substrate2_id = ?)) or ((substrate1_id = ?) and (substrate2_id = ?))",
      substrate1.id, substrate2.id, substrate2.id, substrate1.id
    )
  }
  
  scope :entangled, lambda { |metatag,*substrates|
    t = WorkingPair.arel_table
    where( 
      t[:relation].eq( metatag )
      .or( t[:substrate1_id].in( substrates ) )
      .or( t[:substrate2_id].in( substrates ) ) 
    )
  }
  
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
  
  def weaves_with_same_substrates
    WorkingPair.same_substrates(substrate1, substrate2).order("updated_at DESC")
  end
  
  def entangled
    WorkingPair.entangled(relation, substrate1.id, substrate2.id)
  end
  
  def older 
    entangled.where( "updated_at < ?",updated_at ).order("updated_at DESC")
  end
  
  def newer
    entangled.where( "updated_at > ?",updated_at ).order("updated_at ASC")
  end
end
