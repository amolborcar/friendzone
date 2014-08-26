class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :screen_name
      t.timestamps
    end
  end
end
