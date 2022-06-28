require Rails.root.join('lib/redis/config')

$redis = if Rails.env.test?
  MockRedis.new
else
  Redis.new(Redis.configuration)
end
