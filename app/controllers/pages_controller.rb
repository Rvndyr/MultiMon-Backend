class PagesController < ApplicationController
  # def newsapi_headlines
  #   response = HTTP.get("https://newsapi.org/v2/top-headlines?country=us&apiKey=#{Rails.application.credentials.news_api_key}")
  #   articles = JSON.parse(response.body)["articles"]
  #   render json: articles
  # end

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
    response = HTTP
      .headers("Authorization" => "Bearer #{params[:twitch_access_token]}")
      .get("https://api.twitch.tv/helix/streams/followed")
    render json: JSON.parse(response.body)
  end

  # def spotify_search
  #   response = HTTP
  #     .headers("Authorization" => "Bearer #{params[:spotify_access_token]}")
  #     .get("https://api.spotify.com/v1/search?q=#{CGI.escape(params[:search])}&type=artist")
  #   render json: JSON.parse(response.body)
  # end
end
