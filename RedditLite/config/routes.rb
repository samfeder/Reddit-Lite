Rails.application.routes.draw do

  resources :users
  resource :session
  resources :subs do
    resources :posts, only: [:create, :new]
  end

  resources :posts, except: :create do
    resources :comments, only: :new
  end

  resources :comments, except: :new do
    resources :comments, only: :new
  end

end
