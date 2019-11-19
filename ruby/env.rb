class Env
  # @param [Env] outer
  # @param [Array] binds
  # @param [Array] exprs
  def initialize(outer, binds, exprs)
    @outer = outer
    @data = {}
    for i in 0...(binds.length)
      if binds[i] == :&
        @data[binds[i + 1]] = List.new(exprs.drop(i))
        break
      end
      @data[binds[i]] = exprs[i]
    end
  end

  def set(key, val)
    @data[key] = val
  end

  def find(key)
    if @data.key?(key)
      @data[key]
    else
      if @outer
        @outer.find(key)
      else
        nil
      end
    end
  end

  def get(key)
    result = find(key)
    if result.nil?
      raise "#{key} not found"
    end
    result
  end
end
