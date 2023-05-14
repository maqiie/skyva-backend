Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
     #JEWELRY
  get '/jewelry', to: 'jewelry#index'
  post '/jewelry', to: 'jewelry#create'
  delete 'jewelry/:id', to: 'jewelry#destroy', as: 'delete_jewelry'
# /  delete '/jewelry', to: 'jewelry#destroy'




  # Custom routes for user login and registration
  post '/login', to: 'users#login'
  post '/register', to: 'users#create'

  # Custom routes for password reset
  post '/reset_password', to: 'users#reset_password'
  put '/update_password', to: 'users#update_password'



  #cart
  # Other routes...

  post 'add_item', to: 'cart#add_item'
  post 'remove_item', to: 'cart#remove_item'
  get 'calculate_total_price', to: 'cart#calculate_total_price'

end

