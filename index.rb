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
end

# tests

# my_each test
p [1, 2, 3, 4].respond_to?(:my_each) # check response to function name
[1, 2, 3, 4, 5, 6].my_each { |x| p x } # test function work
