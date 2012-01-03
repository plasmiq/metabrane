class CreateNodeDeposits < ActiveRecord::Migration
  def change
    create_table :node_deposits do |t|
      t.string "session"
      t.integer "pivot"
      t.references :substrates
      t.timestamp "clicked_at"
      t.timestamps
    end
  end
end
