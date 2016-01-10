# TumblrDownloader

Image downloader for Tumblr blogs.

Install `tumblr_client` gem from [here](https://github.com/tumblr/tumblr_client)
```
  gem install tumblr_client
```

set `Tumblr` configurations by creating an application.
```
Tumblr.configure do |config|
  config.consumer_key = "consumer_key"
  config.consumer_secret = "consumer_secret"
  config.oauth_token = "access_token"
  config.oauth_token_secret = "access_token_secret"
end
```

set the blog url.

and then run:
```
  ruby tumblr_downloader.rb
```
