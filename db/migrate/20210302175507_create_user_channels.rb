class CreateUserChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :user_channels do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: false
      t.belongs_to :channel, null: false, foreign_key: true, index: false
      t.datetime :joined_at
      t.index [:user_id, :channel_id]

      t.timestamps
    end
  end
end
