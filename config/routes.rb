Invitr::Application.routes.draw do
  resources :rsvps
  root to: 'application#index'
end
