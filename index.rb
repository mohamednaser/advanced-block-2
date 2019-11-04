# frozen_string_literal: true

module Enumerable
  # Custom Enumberable Functions
  def my_each
    return to_enum :my_each unless block_given?

    i = 0
    while i < size
      yield(self[i])
      i += 1
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

  def my_select
    return to_enum :my_each unless block_given?

    new_array = []

    my_each { |element| new_array << element if yield(element) }

    new_array
  end

  def my_all
    return to_enum :my_each unless block_given?

    my_each { |element| return false unless yield(element) == true }

    true
  end

  def my_any
    my_each { |element| return true unless yield(element) == false }
    false
  end

  def my_none(param = nil)
    if block_given?
      my_each { |element| return false if yield(element) == true }
      true
    else
      my_each { |element| return false if (element == param) == true }
      true
    end
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

  def my_inject(initial_value_or_symbol = nil)
    p self
    p initial_value_or_symbol.is_a? Symbol
    result = 1

    if block_given?
      # result = initial_value_or_symbol unless initial_value_or_symbol.nil?

      my_each { |element| result = yield(result, element) }

      result
    else
      my_each { |element| result = element.send(initial_value_or_symbol) }

    end
  end

  def multiply_els
    result = 1
    my_each { |element| result *= element }
    result
  end
end


newArray = ["dog", "door", "rod", "blade"]
newArray[0] = 5 
p newArray.none(5)