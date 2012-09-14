Mapa76::Application.routes.draw do
  resources :people do
    post "blacklist", :on => :member
  end

  resources :documents do
    get 'status', :on => :collection
    member do
      get 'context'
      get 'comb'
    end
  end

  namespace :api do
    resources :documents
    resources :people
    resources :registers
  end

  root :to => "welcome#index"
end
