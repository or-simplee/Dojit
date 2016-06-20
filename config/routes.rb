Rails.application.routes.draw do
  devise_for :users
  resources :posts

  get 'about' => 'welcome#about'
  #get 'welcome/contact'
  root to: 'welcome#index'
end
