class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.text :id_str
      t.datetime :tweet_created_at
      t.text :tweet_text
      t.text :user_who_posted
      t.text :retweeted_status
      t.text :retweeted
      t.boolean :mention
      t.timestamps
    end
  end
end
