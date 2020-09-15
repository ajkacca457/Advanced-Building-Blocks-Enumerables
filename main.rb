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
  
end
