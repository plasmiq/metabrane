class NodeDeposit < ActiveRecord::Base
  belongs_to :substrate
  belongs_to :working_pair
  
  def substrates
    nodes = NodeDeposit.find_all_by_session( session )
    substrates = nodes.map { |node| node.substrate } if nodes
    substrates || []
  end
  
  def metatags 
    nodes = NodeDeposit.find_all_by_session( session )
    metatags = nodes.map { |node| node.working_pair.relation } if nodes
    metatags.uniq || []  
  end
end
