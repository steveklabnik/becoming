require "becoming/version"

module Becoming
  def becoming(mod)
    @becoming = mod    
  end

  def method_missing(m, *args, &blk)
    if @becoming && @becoming.public_method_defined?(m)
      @becoming.instance_method(m).bind(self).call(*args, &blk)
    else
      super
    end
  end

  def respond_to_missing?(m, include_all=false)
    if @becoming && @becoming.public_method_defined?(m)
      true
    else
      super
    end
  end
end

module NullObject
  def method_missing(m, *args, &blk); end
end
