Rails.application.routes.draw do
  # user login session create (internally)
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  #get list of users (internally)
  get "/users" => "users#index"
  
  #Twitch oAuth Routes
  post "/twitch_authorize" => "pages#twitch_authorize"
  
  # edit these routes:
  get "/twitch_user_info" => "pages#twitch_user_info"


end
