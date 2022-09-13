redis = Rails.root.join('lib/redis/config')
schedule = Rails.root.join('config/schedule.yml')

require redis

Sidekiq.configure_client do |config|
  config.redis = Redis.configuration
end

Sidekiq.configure_server do |config|
  config.redis = Redis.configuration
  config.logger.level = Logger.const_get(ENV.fetch('LOG_LEVEL', 'info').upcase.to_s)
end

Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule) if File.exist?(schedule) && Sidekiq.server?
