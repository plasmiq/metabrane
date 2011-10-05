class AddStatusToWorkingPair < ActiveRecord::Migration
  def change
    add_column :working_pairs, :status, :integer, :default => 1
  end
end
