class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :channel, null: false, foreign_key: true, index: false
      t.text :content
      t.index [:channel_id, :user_id]

      t.timestamps
    end
  end
end
