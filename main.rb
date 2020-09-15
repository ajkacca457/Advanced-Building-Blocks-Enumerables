# frozen_string_literal: true

module Enumerable
  # my_each method

  def my_each
    index = 0
    while index < length
      yield(self[index])
      index += 1
    end
  end

  #----------#my_each_with_index-----------

  def my_each_with_index
    index = 0
    while index < length
      yield(self[index], index)
      index += 1
    end
  end

  # 3.my_all method

  def my_all?(argument = nil)
    result = true

    if argument.nil? && !block_given?
      my_each { |item| result = false if item.nil? || !item }
    else
      my_each { |item| result = false unless yield(item) }
    end
    result
  end

  # 4.my_any method

  def my_any?(argument = nil)
    result = false
    if argument.nil? && !block_given?
      my_each { |item| result = true if item.nil? || !item }
    else
      my_each { |item| result = true if yield(item) }
    end
    result
  end

  # 5.my_select method

  def my_select
    results = []
    my_each { |x| results.push(x) if yield x }
    results
  end

  # 6.my_count method

  def my_count(argument = nil)
    counter = 0
    if block_given?
      my_each { |item| counter += 1 if yield(item) }
    elsif !argument.nil?
      my_each { |item| counter += 1 if argument == item }
    else
      counter = length
    end
    counter
  end

  # 7.my_none method

  def my_none?(argument = nil, &block)
    !my_any?(argument, &block)
  end

  # 8.my_map method

  def my_map(proc = nil)
    results = []
    if proc.nil?
      my_each { |item| results.push(yield(item)) }
    else
      my_each { |item| results.push(proc.call(item)) }
    end
    results
  end

  # 9.my_inject method

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

  # 10.my_multiply_els method
  def multiply_els
    my_inject(:*)
  end
end

# start of testing

# myarray = [1, 6, 3, 4, 5, 6, 12]

# puts myarray.my_each {|item| puts item*2}
# puts myarray.my_each_with_index {|item,index| puts"#{index} is #{item} "}
# puts myarray.my_all?
# puts [1,2,3,nil].my_any?
# puts myarray.my_select{|item| item<10}
# puts myarray.my_count(6)
# puts myarray.my_none?
# puts myarray.my_map {|item| item*5}
# myproc=Proc.new{|item| item+20}
# puts myarray.my_map(&myproc)
# puts myarray.my_inject{|result, element| result * element}
# puts myarray.my_inject(:*)
