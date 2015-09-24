Rails.application.routes.draw do

namespace :api,:path => "", :defaults => {:subdomain => 'api',:format => :json , :content_type => "application/json"} do
  namespace :v1 do
    resources :music_groups do 
      resources :albums do 
        resources :album_tracks
      end
      
    

    end
    resources :search_album_tracks
    resources :search_albums
    resources :search_music_groups
  end
end

  resources :artists do 
    member do
     get :delete
    end
      resources :music_groups do
      member do
        get :delete
      end
            resources :albums do
        member do
          get :delete
        end
          resources :album_tracks do
          member do
            get :delete
          end
    
           end
       end

    end

end  

    resources :music_companies do 
    member do
     get :delete
    end
  resources :labels do
    member do
      get :delete
    end
  end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
