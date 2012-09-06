Mapa76::Application.routes.draw do
  resources :documents do
    get 'status', :on => :collection
    member do
      get 'context'
    end
  end

  root :to => "welcome#index"
end
