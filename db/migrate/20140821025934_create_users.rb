class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :screen_name
      t.string :token_key
      t.string :token_secret
    end
  end
end
