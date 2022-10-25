Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#top'
  devise_for :users
  post '/pages/guest_sign_in', to: 'pages#guest_sign_in'
  post '/pages/admin_guest_sign_in', to: 'pages#admin_guest_sign_in'
  get 'top', to: 'pages#top', as: :top 
  get 'user/:id/my_page', to: 'pages#my_page', as: :my_page 
  resources :projects, shallow: true do
    resources :themes, except: :show
    collection do
      get 'search'
    end
    member do
      get 'public_on', to: 'projects#public_on', as: :public_on 
      get 'public_off', to: 'projects#public_off', as: :public_off 
    end
  end
  get 'user/:user_id/theme/:id', to: 'themes#show', as: :three 
  resources :favorites, only: %i[index create destroy]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
