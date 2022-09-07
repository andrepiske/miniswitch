# frozen_string_literal: true

describe Miniswitch::Switcher do
  REDIS_URL = "redis://127.0.0.1/13"

  before do
    redis.flushdb
  end

  let(:switcher) { Miniswitch.create(REDIS_URL, prefix: 'test') }

  describe '#set_int' do
    it 'sets an integer' do
      switcher.group(:foo).set_int(:bar, 1337)

      expect(redis.get('test:foo:v:bar')).to eq('1337')

      expect(switcher.group(:foo).get_int(:bar)).to be(1337)
    end
  end

  describe '#set_bool' do
    it 'sets an integer' do
      switcher.group(:bar).set_bool(:lala, true)

      expect(redis.get('test:bar:v:lala')).to eq('t')

      expect(switcher.group(:bar).get_bool!(:lala)).to be true
    end
  end

  private

  def redis
    @redis ||= Redis.new(url: REDIS_URL)
  end
end
