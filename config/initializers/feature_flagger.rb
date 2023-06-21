# Feature Flagger (https://github.com/ResultadosDigitais/feature_flagger)
# In order to enable Feature Flagger in your application, you must:
# - Uncomment the gem on Gemfile
# - Uncomment the lines on this file
# - Uncomment the redis service on docker-compose.yml

# require 'redis-namespace'
# require 'feature_flagger'
# 
# FeatureFlagger.configure do |config|
#   redis = Redis.new(host: ENV['REDIS_URL'])
#   namespaced = Redis::Namespace.new('feature_flagger', redis: redis)
#   config.storage = FeatureFlagger::Storage::Redis.new(namespaced)
# end
