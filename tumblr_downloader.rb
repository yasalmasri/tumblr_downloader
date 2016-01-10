require 'pry-rails'
require 'tumblr_client'
require './lib/tumblr_downloader'
require 'open-uri'

# Check tumblr API for more info:
# https://www.tumblr.com/docs/en/api/v2

defaults = {
  site: 'masysco.tumblr.com',
  type: 'photo', limit: 50, offset: 0
}

Tumblr.configure do |config|
  config.consumer_key = "consumer_key"
  config.consumer_secret = "consumer_secret"
  config.oauth_token = "access_token"
  config.oauth_token_secret = "access_token_secret"
end

td = TumblrDownloader.new(defaults)


puts "posts count: #{td.posts_count}"
puts "images count: #{td.images_count}"
puts "total posts: #{td.total_posts}"
td.download_images
