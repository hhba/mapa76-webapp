Mapa76::Application.routes.draw do
  devise_for :users

  resources :people do
    post "blacklist", :on => :member
  end

  resources :projects, :except => [:edit, :update, :delete]

  resources :documents do
    get 'status', :on => :collection
    get 'search', :on => :collection
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
