Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
     #JEWELRY
  get '/jewelry', to: 'jewelry#index'
  post '/jewelry', to: 'jewelry#create'
  delete '/jewelry', to: 'jewelry#destroy'




  # Custom routes for user login and registration
  post '/login', to: 'users#login'
  post '/register', to: 'users#create'

  # Custom routes for password reset
  post '/reset_password', to: 'users#reset_password'
  put '/update_password', to: 'users#update_password'

end

