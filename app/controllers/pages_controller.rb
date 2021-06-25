class PagesController < ApplicationController

  # def newsapi_headlines
  #   response = HTTP.get("https://newsapi.org/v2/top-headlines?country=us&apiKey=#{Rails.application.credentials.news_api_key}")
  #   articles = JSON.parse(response.body)["articles"]
  #   render json: articles
  # end
  # Twitch.configure do |config|
  #   config.client_id = Rails.application.credentials.twitch_client_id,
  #   config.api = Twitch::V2
  # end
  
  # client_a = Twitch.instance do |config|
  #   config.client_id = Rails.application.credentials.twitch_client_id
  # end
  # channel = client_b.channels.get('lookitslou')
  # puts "#{channel}"

  def twitch_authorize
    response = HTTP.post(
      "https://id.twitch.tv/oauth2/token",
      form: {
        client_id: Rails.application.credentials.twitch_client_id,
        client_secret: Rails.application.credentials.twitch_client_secret,
        code: params[:code],
        grant_type: "authorization_code",
        redirect_uri: "http://localhost:8080",
        
      },
    )
    render json: JSON.parse(response.body)
  end

  def twitch_user_info
    # get twitch user id
    response = HTTP
      .headers("Authorization" => "Bearer #{params[:twitch_access_token]}", "Client-Id"=>Rails.application.credentials.twitch_client_id)
      .get("https://api.twitch.tv/helix/users")
    twitch_user_id = response.parse(:json)["data"][0]["id"]
    puts "HELLO"
    pp twitch_user_id
    # get twitch follows using user id
    response = HTTP
      .headers("Authorization" => "Bearer #{params[:twitch_access_token]}", "Client-Id"=>Rails.application.credentials.twitch_client_id)
      .get("https://api.twitch.tv/helix/streams/followed?user_id=#{twitch_user_id}")

      
    render json: JSON.parse(response.body)
  end

  
  # def spotify_search
  #   response = HTTP
  #     .headers("Authorization" => "Bearer #{params[:spotify_access_token]}")
  #     .get("https://api.spotify.com/v1/search?q=#{CGI.escape(params[:search])}&type=artist")
  #   render json: JSON.parse(response.body)
  # end
  
end
