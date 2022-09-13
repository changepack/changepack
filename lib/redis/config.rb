class Redis
  def self.configuration
    @configuration ||= {
      url: ENV.fetch('REDIS_URL', 'redis://localhost:6379'),
      password: ENV.fetch('REDIS_PASSWORD', nil).presence,
      ssl_params: { verify_mode: Changepack.redis_ssl_verify_mode }
    }
  end
end
