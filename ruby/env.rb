
class Env
  # @param [Env] outer
  def initialize(outer)
    @outer = outer
    @data = {}
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
