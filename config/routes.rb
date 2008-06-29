ActionController::Routing::Routes.draw do |map|
  map.with_options(:path_prefix => ':account_name') do |account|
    account.resources :backlog, :controller => 'backlog', :collection => {:export => :get, :feed => :get, :pdf => :get, :search => :post, :search_tags => :get, :sprint => :get, :sort_release => :get, :sort_unassigned => :get, :sort_sprint => :get}
    account.resources :sprints, :member => {:plan => :get, :overview => :get}
    account.resources :user_stories, :member => {:copy => :post, :remove_from_sprint => :post, :create_via_add => :post, :create_task => :post} do |user_story|
      user_story.resources :tasks, :member => {:move_up => :post, :move_down => :post, :release => :post, :claim => :post}
    end
  end


  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "signup"
  # map.connect 'project/overview/:id', :controller => "project/overview", :action => 'index'

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':account_name/:controller/:action/:id'
  map.connect ':account_name', :controller => "backlog"

  map.connect ':controller/:action/:id'
end
