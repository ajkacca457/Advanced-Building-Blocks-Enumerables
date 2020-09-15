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
      my_each { |item| return false if yield(item) == false }
      return true
    elsif arg.nil?
      my_each { |item| return false if item.nil? || item == false }
    elsif !arg.nil? && (arg.is_a? Class)
      my_each { |item| return false if item.class != item }
    elsif !arg.nil? && arg.class == Regexp
      my_each { |item| return false unless arg.match(item) }
    else
      my_each { |item| return false if item != arg }
    end
    true
  end

  #----------#my_any-----------

  def my_any?(argument = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
      false
    elsif argument.nil?
      my_each { |item| return true if item }
    elsif !argument.nil? && (argument.is_a? Class)
      my_each { |item| return true if item.class == argument }
    elsif !argument.nil? && argument.class == Regexp
      my_each { |item| return true if argument.match(item) }
    else
      my_each { |item| return true if item == argument }
    end
    false
  end

  #----------#my_select-----------

  def my_select
    return to_enum unless block_given?

    results = []
    to_a.my_each { |x| results.push(x) if yield x }
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

  def my_inject(*argument)
    accumulator = argument[0] if argument[0].is_a?(Integer)
    operator = argument[0].is_a?(Symbol) ? argument[0] : argument[1]

    if operator
      my_each { |item| accumulator = accumulator ? accumulator.send(operator, item) : item }
      return accumulator
    end
    my_each { |item| accumulator = accumulator ? yield(accumulator, item) : item }
    accumulator
  end

  #----------#my_multiply_els-----------
  def multiply_els
    my_inject(:*)
  end
end

# start of testing

# myarray = [1, 6, 3, 4, 5, 6, 12]

# puts myarray.my_each {|item| puts item*2}
# puts myarray.my_each_with_index {|item,index| puts"#{index} is #{item} "}
# puts [1,21,1,3,45,13,5,12,nil].my_all?
# puts [1,21,1,3,45,13,5,12,nil].my_all?{|item| item<50}
# puts [1,2,3,nil].my_any?
# puts myarray.my_select{|item| item<10}
# puts myarray.my_count(6)
# puts myarray.my_none?
# puts myarray.my_map {|item| item*5}
# myproc=Proc.new{|item| item+20}
# puts myarray.my_map(&myproc)
# puts (1..20).my_inject(3){|result, element| result * element}
# puts myarray.my_inject(:*)
