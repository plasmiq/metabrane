class AddWeavementToNodedeposit < ActiveRecord::Migration
  def change
    add_column :node_deposits, :working_pair_id, :integer
  end
end
