require "becoming/version"

module Becoming
  def becoming(mod=nil)
    @becoming ||= []
    mod && @becoming |= [mod]
    @becoming
  end

  def unbecoming(mod)
    becoming.delete(mod)
  end

  def method_missing(m, *args, &blk)
    if match = becoming.find { |b| b.public_method_defined?(m) }
      match.instance_method(m).bind(self).call(*args, &blk)
    else
      super
    end
  end

  def respond_to_missing?(m, include_all=false)
    if becoming.any? { |b| b.public_method_defined?(m) }
      true
    else
      super
    end
  end
end

module Becoming
  module NullObject
    def self.public_method_defined?(m)
      true
    end

    def self.instance_method(m)
      ByPass.instance_method(:bypass)
    end

    module ByPass
      def bypass(*args, &blk); end
    end
  end
end
