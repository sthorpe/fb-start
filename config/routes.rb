ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.home '/home', :controller => 'streams', :action => 'new'
  
  map.root :controller => "news", :action => "index"
  
  map.resources :users, :collection => { :link_user_accounts => :get,
                                         :home => :get }

  map.resource :session
  
  map.resources :news
  map.resources :feeds
  map.resources :streams, :collection => { :search_streams => :post,
                                           :send_email => :get}
  
  map.resources :categories
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
