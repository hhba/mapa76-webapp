Mapa76::Application.routes.draw do
  resources :documents do
    get 'status', :on => :collection
  end

  root :to => "welcome#index"
end
