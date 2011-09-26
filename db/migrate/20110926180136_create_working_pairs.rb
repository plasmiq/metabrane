class CreateWorkingPairs < ActiveRecord::Migration
  def change
    create_table :working_pairs do |t|
      t.string :image1_url
      t.string :image2_url
      t.text :relation

      t.timestamps
    end
  end
end
