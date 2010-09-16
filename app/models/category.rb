class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :tags, :dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def to_s
    name.titleize
  end
end
