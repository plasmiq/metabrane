class CreateMetacodes < ActiveRecord::Migration
  def change
    create_table :metacodes do |t|

      t.timestamps
    end
  end
end
