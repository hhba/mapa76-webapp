Mapa76::Application.routes.draw do
  resources :documents

  root :to => "welcome#index"
end
