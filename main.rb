# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  #----------my_each method-----------
  def my_each
    return to_enum unless block_given?

    i = 0
    array = to_a
    while i < array.length
      yield array[i]
      i += 1
    end
    self
  end

  #----------#my_each_with_index-----------
  def my_each_with_index
    return to_enum unless block_given?

    i = 0
    array = to_a
    while i < array.length
      yield(array[i], i)
      i += 1
    end
    self
  end

  #----------#my_all-----------
  def my_all?(arg = nil)
    if block_given?
      my_each { |item| return false unless yield(item) }
      return true
    end
    if arg
      case arg.class.to_s
      when 'Class' then my_all? { |item| item.is_a?(arg) }
      when 'Regexp' then my_all? { |item| item =~ arg }
      else my_all? { |item| item == arg }
      end
    else
      my_all? { |item| item }
    end
  end

  #----------#my_any-----------

  def my_any?(arg = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      return false
    end
    if arg
      case arg.class.to_s
      when 'Class' then my_any? { |item| item.is_a?(arg) }
      when 'Regexp' then my_any? { |item| item =~ arg }
      else my_any? { |item| item == arg }
      end
    else
      my_any? { |item| item }
    end
  end
  #----------#my_select-----------

  def my_select
    return to_enum unless block_given?

    results = []
    to_a.my_each { |item| results.push(item) if yield item }
    results
  end

  #----------#my_count-----------
  def my_count(argument = nil)
    counter = 0
    if block_given?
      to_a.my_each { |item| counter += 1 if yield(item) }
    elsif !argument.nil?
      to_a.my_each { |item| counter += 1 if argument == item }
    else
      counter = to_a.length
    end
    counter
  end

  #----------#my_none-----------
  def my_none?(argument = nil, &block)
    !my_any?(argument, &block)
  end

  #----------#my_map-----------

  def my_map(proc = nil)
    return to_enum unless block_given?

    results = []
    if proc.nil?
      my_each { |item| results.push(yield(item)) }
    else
      my_each { |item| results.push(proc.call(item)) }
    end
    results
  end

  #----------#my_inject-----------
  def my_inject(num = nil, sym = nil)
    if block_given?
      accumulator = num
      my_each { |item| accumulator = accumulator.nil? ? item : yield(accumulator, item) }
      accumulator
    elsif !num.nil? && (num.is_a?(Symbol) || num.is_a?(String))
      accumulator = nil
      my_each { |item| accumulator = accumulator.nil? ? item : accumulator.send(num, item) }
      accumulator
    elsif !sym.nil? && (sym.is_a?(Symbol) || sym.is_a?(String))
      accumulator = num
      my_each { |item| accumulator = accumulator.nil? ? item : accumulator.send(sym, item) }
      accumulator
    else
      raise LocalJumpError unless block_given?
    end
  end
end

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

def multiply_els(arr)
  arr.my_inject { |result, element| result * element }
end
