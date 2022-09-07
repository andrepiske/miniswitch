# frozen_string_literal: true

class Miniswitch::Switcher
  def initialize(redis_url, prefix, pool_size: 4)
    @prefix = prefix
    @redis = ConnectionPool.new(size: pool_size, timeout: 5) do
      Redis.new(url: redis_url)
    end
  end

  def with_redis(&b)
    @redis.with(&b)
  end

  def group(name)
    Miniswitch::Group.new(self, name, nil)
  end

  def root
    group(nil)
  end

  def prefix_slug
    @prefix ? [@prefix] : []
  end
end
