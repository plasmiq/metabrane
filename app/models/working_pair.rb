class WorkingPair < ActiveRecord::Base
  belongs_to :substrate1,:class_name => "Substrate", :foreign_key => "substrate1_id"
  belongs_to :substrate2,:class_name => "Substrate", :foreign_key => "substrate2_id"
  has_many :favorites
  
  validates :relation, :presence => true
  
  scope :newest, order("working_pairs.created_at DESC")
  scope :oldest, order("working_pairs.created_at ASC")  
  scope :group_substrates, group("substrate1_id, substrate2_id")
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
  scope :related, lambda { |metatag,substrate1,substrate2|
    t = WorkingPair.arel_table
    substrates = [substrate1.id,substrate2.id]
    where( 
      t[:relation].eq( metatag )
      .or( t[:substrate1_id].in( substrates ) )
      .or( t[:substrate2_id].in( substrates ) ) 
    ).where("substrate1_id != ? and substrate2_id != ?",substrate1.id, substrate2.id)
    .group_substrates
  }
  scope :older_than, lambda { |data,column = 'created_at'| 
    where( "#{column} < ?", data ).order("#{column} DESC")
  }
  scope :newer_than, lambda { |data,column = 'created_at'|
    where( "#{column} > ?", data ).order("#{column} ASC")
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
  
  def metatags
    WorkingPair.same_substrates(substrate1, substrate2).order("created_at ASC")
  end
  
  def related
    WorkingPair.related(relation,substrate1,substrate2)
  end
  
  def older 
    related.older_than( created_at, "created_at" )
  end
  
  def newer
    related.newer_than( created_at, "created_at" )
  end
end
