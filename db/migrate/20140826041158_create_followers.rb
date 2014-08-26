class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :screen_name
      t.timestamps
    end
  end
end
