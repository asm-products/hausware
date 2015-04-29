Rails.application.routes.draw do


  namespace :kitchen do
  get 'orders/index'
  end

  namespace :superuser do
    resources :users
  end

  namespace :account do
    resources :reservations
    resources :users
  end

  namespace :admin do
    resources :orgs do
      resources :locations do
        resources :memberships
        resources :spaces do
          resources :slides
        end
        resources :menus do
          resources :goods
        end
      end
      resources :settings
      resources :memberships
    end
  end

  namespace :reception do
    resources :orgs do
      resources :locations do
        resources :reservations do
          member do
            put :checkedin
          end
        end
      end
    end 
  end
  
  resources :orgs do
    resources :memberships
    resources :locations do
      resources :memberships
      resources :menus do
        resources :goods
      end
      resources :orders do
        resources :ordered_goods
      end
      resources :spaces do
        resources :reservations do
          collection do
            post :validate
          end
          member do
            get :cancel
            put :canceled
            patch :canceled
          end
        end
        resources :slides
      end
    end
  end
    
  # OmniAuth for all providers, see `config/initializers/omniauth.rb` for more
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'sessions/new'
  get 'sessions/destroy'
  
  resources :users
  # Temporary charges URL
  resources :charges
  
  # You can have the root of your site routed with "root"
  root 'welcome#index'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
