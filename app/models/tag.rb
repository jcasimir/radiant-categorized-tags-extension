class Tag < ActiveRecord::Base
  attr_accessible :name, :category_id
  
  belongs_to :category
  has_many :taggings, :dependent => :destroy
  has_many :places,    :through => :taggings, :source => :place,
                      :conditions => "taggings.taggable_type = 'Place'"
  has_many :events,    :through => :taggings, :source => :event,
                      :conditions => "taggings.taggable_type = 'Event'"
  
  validates_presence_of :category
  validates_uniqueness_of :name, :scope => :category_id
  
  def to_s
    name.titleize
  end  
  
  def to_param
    name.downcase.gsub(" ", "_")
  end
  
  def self.find_by_param(input)
    # Temp Hack
    Tag.all.detect{|t| t.to_param == input}
  end
  
  def count(type)
    unless type.nil? || type.empty?
      self.taggings.count(:conditions => "taggings.taggable_type = '#{type.capitalize}'")
    else
      self.taggings.count
    end
  end
  
  def self.create_default_neighborhoods
    cat = Category.find_or_create_by_name("neighborhoods")
    ["Adams Morgan", "Anacostia", "Barry Farm", "Brentwood", "Brookland", "Capitol Hill", 
     "Chevy Chase", "Chinatown", "Cleveland Park", "Columbia Heights", "Dupont Circle", 
     "Federal Triangle", "Foggy Bottom", "Friendship Heights", "Georgetown", "H Street Corridor", 
     "Kalorama", "Le Droit Park", "Logan Circle", "Mount Pleasant", "NoMa", "Penn Quarter", 
     "Petworth", "Shaw", "Southeast", "Takoma", "Tenleytown", "Trinidad", "U Street Corridor", 
     "West End", "Woodley Park"].each do |neighborhood|
       cat.tags.find_or_create_by_name(neighborhood.downcase)
    end
  end
end
