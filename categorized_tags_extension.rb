# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class CategorizedTagsExtension < Radiant::Extension
  version "0.1"
  description "Tagging with categories (one category has many tags has many taggables)"
  url "http://github.com/jcasimir/radiant_categorized_tags_extension"
  
  extension_config do |config|
    config.gem 'formtastic'  # This doesn't work...?
  end
  
  def activate
    tab 'Content' do
      add_item "Tags", "/admin/tags"
    end 
    
    Page.send :include, CategorizedTagsTags
  end
end
