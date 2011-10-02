class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :working_pair
      t.references :user
      t.timestamps
    end
  end
end
