Mapa76::Application.routes.draw do
  devise_for :users

  resources :people do
    post "blacklist", :on => :member
  end

  resources :projects, :except => [:edit, :update, :delete] do
    member do
      get    'add_documents'
      post   'add_document'
      delete 'remove_document'
    end
  end

  resources :documents do
    get 'status', :on => :collection
    member do
      get 'context'
      get 'comb'
      get 'download'
    end
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :projects
    end
    resources :documents
    resources :people
    resources :projects
    resources :registers
  end

  root :to => "welcome#index"

  match "#{Mapa76::Application.config.thumbnails_path}/:id" => "documents#generate_thumbnail"
end
