require "resolv-replace"

Sidekiq::Extensions.enable_delay!

Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV["redis_host"]
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV["redis_host"]
  }
end
