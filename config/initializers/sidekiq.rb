require 'sidekiq'
require 'sidekiq/web'

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

if Rails.env.production?
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(user), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USER'])) &
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end
end
