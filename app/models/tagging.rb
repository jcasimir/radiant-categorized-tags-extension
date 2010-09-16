class Tagging < ActiveRecord::Base
  attr_accessible :taggable_id, :tag_id
  
  belongs_to :tag
  belongs_to :taggable, :polymorphic => :true
  belongs_to :place,     :class_name => "Place",
                          :foreign_key => "taggable_id"
  belongs_to :event,     :class_name => "Event",
                          :foreign_key => "taggable_id"                          
  
  validates_presence_of :tag, :taggable
end
