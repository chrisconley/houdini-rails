ActionController::Routing::Routes.draw do |map|
  map.resources :houdini_postbacks,
    :controller => 'houdini/postbacks',
    :only => [:create],
    :path_prefix => ":subject_class/:subject_id/:task_name" 
end