class AddUrlToSubstrate < ActiveRecord::Migration
  def change
     add_column :substrates, :url, :string
  end
end
