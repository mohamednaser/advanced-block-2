# frozen_string_literal: true

module Enumerable
  # Custom Enumberable Functions
  def my_each
    i = 0
    while i < size
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end

  def my_select
    new_array = []

    my_each { |element| new_array << element if yield(element) }

    new_array
  end

  def my_all
    my_each { |element| return false unless yield(element) == true }

    true
  end

  def my_any
    my_each { |element| return true unless yield(element) == false }
    false
  end

  def my_none
    my_each { |element| return false if yield(element) == true }
    true
  end

  def my_count
    size
  end

  def my_map
    i = 0
    array2 = []
    while i < size
      array2 << if block_given?
                  yield(self[i])
                else
                  proc.call(self[i])
                end
      i += 1
    end
    array2
  end

  def my_inject(initial_value_or_symbol = nil)
    if block_given?
      result = 0

      result = initial_value_or_symbol unless initial_value_or_symbol.nil?

      my_each { |element| result = yield(result, element) }

      result
    else
      my_each { |element| element.Method(initial_value_or_symbol) }

    end
  end

  def multiply_els
    result = 1
    my_each { |element| result *= element }
    result
  end
end

# tests

# my_each
# p [1, 2, 3, 4].respond_to?(:my_each) # check response to function name
# [1, 2, 3, 4, 5, 6].my_each { |x| p x } # test function work

# my_each_with_index
# p [1, 2, 3, 4].respond_to?(:my_each_with_index) # check response to function name
# p [1,2,3,4,5,6,7,8].my_each_with_index{|element , index| p "add element #{element} at index #{index}"}

# my_select
# p [1, 2, 3, 4].respond_to?(:my_select) # check response to function name
# p [1, 2, 3, 4, 5, 6, 7, 8].my_select { |element| element > 5 }

# my_all
# p [1, 2, 3, 4].respond_to?(:my_all) # check response to function name
# p [1, 2, 3, 4, 5, 6, 7, 8].my_all { |element| element >= 1 } # test my_all function

# my_any
# p [1, 2, 3, 4].respond_to?(:my_any) # check response to function name
# p [1, 2, 3, 4, 5, 6, 7, 8].my_any { |element| element >= 8 } # test my_any function

# my_none
# p [1, 2, 3, 4].respond_to?(:my_none) # check response to function name
# p [1, 2, 3, 4, 5, 6, 7, 8].my_none { |element| element > 6 } # test my_none function

# my_count
# p [1, 2, 3, 4].respond_to?(:my_count) # check response to function name
# p [1, 2, 3, 4, 5, 6, 7, 8].my_count { |element| element > 6 } # test my_count function

# my_map
# p [1, 2, 3, 4].respond_to?(:my_map) # check response to function name
# p [1, 2, 3, 4, 5, 6, 7, 8].my_map { |element| element + 6 } # test my_map function

# my_inject
# p [1, 2, 3, 4].respond_to?(:my_inject) # check response to function name
# p [1, 2, 3, 4].my_inject { |sum, _element| sum + _element } # test my_inject function
# p [1, 2, 3, 4].my_inject(8) { |sum, element| sum + element } # test my_inject function with inital value
# p [1, 2, 3, 4].my_inject(:+) # test my_inject function with symbol

# my_map function with proc parmater
# sum_proc = proc do |element|
#   element + 6
# end
# p [1, 2, 3, 4, 5, 6, 7, 8].my_map(&sum_proc) # test my_map function
