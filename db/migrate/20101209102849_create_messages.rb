class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :body
      t.integer :author_id
      t.integer :recipient_id
      t.boolean :read, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
