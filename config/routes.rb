ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  
  map.root :controller => "users", :action => "home"
  
  map.resources :users, :collection => {:link_user_accounts => :get,
                                        :home => :get}

  map.resource :session
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
