Rails.application.routes.draw do
  # user login session create (internally)
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  #get list of users (internally)
  get "/users" => "users#index"
  
  #Twitch oAuth Routes
  post "/twitch_authorize" => "pages#twitch_authorize"
  
  # edit these routes:
# get "/newsapi_headlines" => "pages#newsapi_headlines"
# get "/spotify_user_info" => "pages#spotify_user_info"
# get "/spotify_search" => "pages#spotify_search"

end
