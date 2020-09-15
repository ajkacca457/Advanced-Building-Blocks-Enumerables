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


end
