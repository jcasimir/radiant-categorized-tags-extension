module CategorizedTagsTags
  include Radiant::Taggable
  include TagsHelper
  include TaggingsHelper
  include CategoriesHelper
  
  tag 'category' do |tag|
    tag.expand
  end
  
  tag 'category:tags' do |tag|
    tag.expand
  end
  
  tag 'category:tags:each' do |tag|
    category = Category.find_by_name(tag.attr['name'])
    
    unless category.nil?
      category.tags.collect do |t|
        tag.locals.my_tag = t
        tag.expand
      end
    end
  end
  
  #r:category:pages name="neighborhoods" pages="2"
  tag 'tag:category:pages' do |tag|
    category = Category.find_by_name(tag.attr['name'])
    
    unless category.nil?
      page_count = tag.attr['pages'].to_i || 2
      target_size = (category.tags.count.to_f / page_count).ceil
      (0...page_count).collect do |i|
        start_index = i*target_size
        end_index = start_index + target_size
        tag.locals.tags = category.tags[start_index..end_index]
        tag.expand
      end
    end
  end
  
  tag 'tag:category:page' do |tag|
    tag.locals.tags.collect do |my_tag|
      tag.locals.my_tag = my_tag
      tag.expand
    end
  end
  
  tag 'tag' do |tag|
    tag.expand
  end
  
  tag 'tag:name' do |tag|
    tag.locals.my_tag.to_s
  end
  
  tag 'tag:param' do |tag|
    tag.locals.my_tag.to_param
  end
  
  tag 'tag:count' do |tag|
    tag.locals.my_tag.count(tag.attr['type'])
  end
end