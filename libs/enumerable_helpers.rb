# frozen_string_literal: true

module Enumerable
  def my_select
    return to_enum :my_each unless block_given?

    new_array = []

    my_each { |element| new_array << element if yield(element) }

    new_array
  end

  def my_count(param = nil)
    size = 0

    if block_given?
      my_each { |element| size += yield(element) ? 1 : 0 }
    elsif param.nil?
      size = self.size
    else
      my_each { |element| size += element == param ? 1 : 0 }
    end

    size
  end

  def my_map
    return to_enum :my_map unless block_given?

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

  def my_inject(param = nil)
    array_input = self.class == Range ? to_a : self # if it range convert it to array
    result = param.nil? || param.is_a?(Symbol) ? array_input[0] : param # initial result

    if block_given?
      starter_pointer = param.nil? ? 1 : 0

      array_input[starter_pointer..-1].my_each do |element|
        result = yield(result, element)
      end

      return result
    end

    if param.is_a? Symbol
      array_input[1..-1].my_each do |element|
        result = result.send(param, element)
      end
      result
    end
  end

  def multiply_els
    result = 1
    my_each { |element| result *= element }
    result
  end
end
