ActionController::Routing::Routes.draw do |map|
  map.resources :postbacks,
    :name_prefix => 'houdini_',
    :controller => 'houdini/postbacks',
    :only => [:create],
    :path_prefix => "houdini/:subject_class/:subject_id/:task_name" 
end