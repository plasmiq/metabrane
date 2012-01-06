class NodedepositRenameColumnForSubstrateId < ActiveRecord::Migration
  change_table :node_deposits do |t|
      t.rename :substrates_id, :substrate_id
  end
end
