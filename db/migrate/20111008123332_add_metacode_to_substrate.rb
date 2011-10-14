class AddMetacodeToSubstrate < ActiveRecord::Migration
  def change
    add_column :substrates, :metacode, :string
  end
end
