class SetupStarterCategoriesAndTags < ActiveRecord::Migration
  def self.up
    c = Category.find_or_create_by_name("place_types")
    ["music", "performing arts", "exhibits", "happy hour", "food", "coffee"].each_with_index do |name, i|
      t = c.tags.find_or_create_by_name(name)
      t.order = i
      t.save
    end
  end

  def self.down
    c = Category.destroy_all
  end
end
