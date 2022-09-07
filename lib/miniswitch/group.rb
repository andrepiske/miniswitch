# frozen_string_literal: true

class Miniswitch::Group
  attr_reader :parent
  attr_reader :switcher
  attr_reader :group_name

  def initialize(switcher, group_name, parent)
    @switcher = switcher
    @group_name = group_name
    @parent = parent
  end

  def group(name)
    Miniswitch::Group.new(@switcher, name, self)
  end

  def set_bool(name, value)
    set_value(name, value ? 't' : 'f', :bool)
  end

  def set_int(name, value)
    set_value(name, Integer(value), :int)
  end

  def get_int(name, default=nil)
    @switcher.with_redis do |r|
      v = r.get(key_for(name))
      v ? Integer(v) : default
    end
  end

  def get_bool!(name)
    v = get_bool(name, nil)
    return v unless v == nil

    raise UndefinedValueError
  end

  def get_bool(name, default=nil)
    @switcher.with_redis do |r|
      v = r.get(key_for(name))
      case v
      when 't'
        true
      when 'f'
        false
      when nil
        default
      else
        raise "Invalid value for bool: '#{v}'"
      end
    end
  end

  # :nodoc:
  def full_slug
    @full_slug ||= begin
      s = @parent ? @parent.full_slug : @switcher.prefix_slug
      s << @group_name if @group_name

      s
    end
  end

  private

  def set_value(name, value, type)
    @switcher.with_redis do |r|
      r.pipelined do |x|
        x.hset(meta_key_for(name), {
          't' => type.to_s,
          'u' => Time.now.to_i
        })
        x.set(key_for(name), value)
      end
    end
  end

  def key_for(name)
    (full_slug + ['v', name]).join(':')
  end

  def meta_key_for(name)
    (full_slug + ['m', name]).join(':')
  end
end
