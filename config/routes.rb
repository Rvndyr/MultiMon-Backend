Rails.application.routes.draw do
  # user login session create
  post "/users" => "users#create"
  post "/sessions" => "sessions#create"

  #

end
