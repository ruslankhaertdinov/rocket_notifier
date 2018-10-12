require 'sidekiq'
require 'sidekiq-scheduler'
require 'rocket-chat-notifier'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISTOGO_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISTOGO_URL'] }
end

class ReportScheduler
  include Sidekiq::Worker
  sidekiq_options retry: 1

  def perform
    puts Time.now
    notifier = RocketChat::Notifier.new(ENV['WEBHOOK_URL'], channel: ENV['CHANNEL'], username: ENV['USERNAME'])
    notifier.ping(ENV['MESSAGE'], icon_emoji: ENV['ICON_EMOJI'])
  end
end
