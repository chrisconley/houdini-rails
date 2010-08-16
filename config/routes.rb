ActionController::Routing::Routes.draw do |map|
  map.resources :postbacks,
    :name_prefix => 'houdini_',
    :controller => 'houdini/postbacks',
    :only => [:create],
    :path_prefix => "houdini/:object_class/:object_id/:task_name" 
end