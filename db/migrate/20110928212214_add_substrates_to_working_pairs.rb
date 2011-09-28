class AddSubstratesToWorkingPairs < ActiveRecord::Migration
  def change
    add_column :working_pairs, :substrate1_id, :integer
    add_column :working_pairs, :substrate2_id, :integer
  end
end
