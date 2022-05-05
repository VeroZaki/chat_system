Rails.application.routes.draw do
  root "applications#index"
  # get '/applications/:token/show_by_token', to: 'applications#show_by_token'
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :applications do 
        resources :chats do
          resources :messages
        end
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

# require 'sidekiq/web'

# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   mount Sidekiq::Web => '/sidekiq'
#   # Applications Routes
#   get '/api/v1/applications/:token', to: 'applications#show'
#   get '/api/v1/applications/', to: 'applications#index'
#   post '/api/v1/applications/:name', to: 'applications#create'
#   post '/api/v1/applications/:token/edit', to: 'applications#update_name'

#   # Chats Routes
#   get '/api/v1/applications/:token/chats', to: 'chats#index'
#   get '/api/v1/applications/:token/chats/:chat_number', to: 'chats#show'
#   post '/api/v1/applications/:token/chats', to: 'chats#create'
#   get '/api/v1/applications/:token/chats/:chat_number/search', to: 'chats#search'

#   # Messages Routes
#   get '/applications/:token/chats/:chat_number/messages', to: 'messages#index'
#   get '/applications/:token/chats/:chat_number/messages/:message_number', to: 'messages#show'
#   post '/applications/:token/chats/:chat_number/messages', to: 'messages#create'
# end