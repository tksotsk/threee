Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#top'
  devise_for :users
  post '/pages/guest_sign_in', to: 'pages#guest_sign_in'
  post '/pages/admin_guest_sign_in', to: 'pages#admin_guest_sign_in'
  get 'top', to: 'pages#top', as: :top 
  resources :projects, shallow: true do
    resources :themes
  end
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
