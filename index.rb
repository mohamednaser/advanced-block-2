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
