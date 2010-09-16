ActionController::Routing::Routes.draw do |map|
  map.namespace :admin, :member => { :remove => :get } do |admin|
    admin.resources :tags
    admin.resources :taggings
    admin.resources :categories
  end
end