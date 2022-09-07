# frozen_string_literal: true

module Miniswitch
  UndefinedValueError = Class.new(StandardError)

  def self.create(redis_url, prefix:)
    Switcher.new(redis_url, prefix)
  end
end

require 'time'
require 'date'
require 'redis'
require 'connection_pool'

require 'miniswitch/switcher'
require 'miniswitch/group'
