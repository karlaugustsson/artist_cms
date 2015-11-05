Rails.application.routes.draw do

root to: 'public#index'
get "artist_activation/register" => "artist_activation#register"
get "artist_activation/unregister" => "artist_activation#unregister"
get "music_companies_login" => "login_music_companies#login"
get "login/artist" => 'login_artist#login'
get "logout/artist" => 'login_artist#logout'
get "music_company_logout" => "login_music_companies#logout"
post "attempt_login_m" => "login_music_companies#attempt_login"
post "attempt_login" => "login_artist#attempt_login"
get '/artist/settings' => 'artists#settings'

get "music_company_grant_publish_permission" => 'music_companies#grant_publish_permission'
get "music_company_revoke_publish_permission" => 'music_companies#revoke_publish_permission'
get '/music_company/settings' => 'music_companies#settings'

namespace :api,:path => "", :defaults => {:subdomain => 'api',:format => :json , :content_type => "application/json"} do
  namespace :v1 do

    resources :search_album_tracks , :only => [:show,:index,:edit,:update]
    resources :search_albums , :only => [:show,:index,:edit,:update]
    resources :search_music_groups , :only => [:show,:index,:edit,:update]
  end
end

  resources :artists  , :except => [:index]do 
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
  resources :albums  , :only => [:index, :show ]do
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
