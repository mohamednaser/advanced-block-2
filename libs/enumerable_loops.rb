# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    array_input = self.class == Range ? to_a : self # cehck if range convert it to array
    pointer = 0
    while pointer < size
      yield(array_input[pointer])
      pointer += 1
    end
  end

  def my_each_with_index
    return to_enum :my_each unless block_given?

    i = 0
    while i < size
      yield(self[i], i)
      i += 1
    end
  end
end
