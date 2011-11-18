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
    where( 
        t[:relation].eq( metatag ).and(
          t[:substrate1_id].not_eq( substrate1.id ).and(
            t[:substrate2_id].not_eq( substrate2.id )
          )
        )
      .or( t[:substrate1_id].eq( substrate1.id )
        .and( t[:substrate2_id].not_eq( substrate2.id ) ) )
      .or( t[:substrate2_id].in( substrate2.id ) 
        .and( t[:substrate1_id].not_eq( substrate1.id ) ) )
    ).group_substrates
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
  
  def substrate_with_id id
    if (substrate1.id == id) 
      substrate1 
    elsif (substrate2.id == id) 
      substrate2
    else
      nil
    end
  end
  
  def metatags
    WorkingPair.same_substrates(substrate1, substrate2).newest
  end
  
  def older_metatags
    WorkingPair
      .same_substrates(substrate1, substrate2)
      .older_than( created_at, "created_at" )
  end
  
  def newer_metatags
    WorkingPair
      .same_substrates(substrate1, substrate2)
      .newer_than( created_at, "created_at" )
  end
  
  def related
    WorkingPair.related(relation,substrate1,substrate2)
  end

  def travel_future direction
    if direction + 1 == 0
      self
    elsif direction > 0 
      newer.offset( direction ).first
    elsif direction < -1  
      older.offset( -1 * direction ).first
    else 
      newer.first
    end
  end  
  
  def travel_past direction
    if direction - 1 == 0
      self
    elsif direction < 0
      older.offset( -1 * direction ).first
    elsif direction > 1
      newer.offset(direction ).first
    else
      older.first
    end
  end
  
  def older 
    related.older_than( created_at, "created_at" )
  end
  
  def newer
    related.newer_than( created_at, "created_at" )
  end
  
  def WorkingPair.clone weave
    new = WorkingPair.new
    new.substrate1 = weave.substrate1
    new.substrate2 = weave.substrate2
    new.relation   = weave.relation
    new
  end
end
