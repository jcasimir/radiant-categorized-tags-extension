class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.references :taggable, :polymorphic => true
      t.references :tag
      t.timestamps
    end
  end
  
  def self.down
    drop_table :taggings
  end
end
