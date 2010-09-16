class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name, :default => ""
      t.integer :category_id
      t.integer :order, :default => 0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tags
  end
end
