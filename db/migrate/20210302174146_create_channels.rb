class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.boolean :is_public, default: true
      t.index :name, unique: true

      t.timestamps
    end
  end
end
