# README

# Here is the backend to my Multi-Mon TV web app built with Ruby on Rails for the backend.

- Ruby version
  `ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-darwin20]`
- Configuration
  Clone this repo, in terminal cd into the /capstone folder, and run bundle install
- Deployment instructions
  Clone this repo, in terminal cd into the /capstone folder, and run `rails s`

Open your insomnia or postman and make a post request to the following: URL: "https://id.twitch.tv/oauth2/token"

with a multipart form that has:

1. client_id: You will need your own client ID by registering to the twitch dev site.
2. client_secret: same as above
3. grant_type: client_credentials
