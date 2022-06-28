class Redis
  def self.configuration
    @configuration ||= {
      url: ENV.fetch('REDIS_URL', 'redis://127.0.0.1:6379'),
      password: ENV.fetch('REDIS_PASSWORD', nil).presence,
      ssl_params: { verify_mode: Changepack.redis_ssl_verify_mode },
      reconnect_attempts: 2,
      network_timeout: 5
    }
  end
end
