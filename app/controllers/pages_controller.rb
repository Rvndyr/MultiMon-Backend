class PagesController < ApplicationController

  def twitch_authorize
    # get access token from front end url. 
    response = HTTP.post(
      "https://id.twitch.tv/oauth2/token",
      form: {
        client_id: Rails.application.credentials.twitch_client_id,
        client_secret: Rails.application.credentials.twitch_client_secret,
        code: params[:code],
        grant_type: "authorization_code",
        redirect_uri: Rails.application.credentials.twitch[:redirect_uri],
        
      },
    )
    render json: JSON.parse(response.body)
  end

  def twitch_user_info
    # get twitch user id
    response = HTTP
      .headers("Authorization" => "Bearer #{params[:twitch_access_token]}", "Client-Id"=>Rails.application.credentials.twitch_client_id)
      .get("https://api.twitch.tv/helix/users")
      pp response.parse(:json)
    twitch_user_id = response.parse(:json)["data"][0]["id"]
    current_user = response.parse(:json)["data"][0]
    # get twitch follows using user id
    response = HTTP
      .headers("Authorization" => "Bearer #{params[:twitch_access_token]}", "Client-Id"=>Rails.application.credentials.twitch_client_id)
      .get("https://api.twitch.tv/helix/streams/followed?user_id=#{twitch_user_id}")
    render json: {user: current_user, follows: JSON.parse(response.body)["data"]}
  end
end
