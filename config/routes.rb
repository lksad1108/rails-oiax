Rails.application.routes.draw do

  namespace :staff, path: "" do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
    resource :account, except: [ :new, :create, :destroy ]
    resource :password, only: [ :show, :edit, :update ]
    resources :customers
    resources :programs do
      resources :entries, only: [] do
        patch :update_all, on: :collection do
      end
    end
  end

  namespace :admin do
    root "top#index"
    get "login" => "sessions#new", as: :login
    resource :session, only: [ :create, :destroy ]
    resources :staff_members do
      resources :staff_events, only: [ :index ]
    end
    resources :staff_events, only: [ :index ]
    resources :allowed_sources, only: [ :index, :create ] do
      delete :delete, on: :collection
    end
  end

  namespace :customer do
    root "top#index"
    get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ] do
        patch :confirm
      end
      resources :programs, only: [ :index, :show ] do
        resource :entry, only: [ :create ] do
          patch :cancel
        end
      end
    end
  end
end
