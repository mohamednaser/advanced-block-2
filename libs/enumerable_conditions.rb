# frozen_string_literal: true

module Enumerable
  def my_all(param = nil)
    if block_given?
      my_each { |element| return false if yield(element) == false }
      true
    end

    if param.nil?
      my_each { |element| return false unless element }
      return true
    end

    my_each { |element| return false if check_input_valid_by_critira(element, param) == false }
    true
  end

  def my_any(param = true, &proc)
    if block_given?
      it_is_proc = !proc.nil?

      my_each { |element| return true if (it_is_proc && proc.call(element)) || (!it_is_proc && yield(element)) }
      return false
    end

    my_each { |element| return true if check_input_valid_by_critira(element, param) }
    false
  end

  def my_none(param = nil)
    if block_given?
      my_each { |element| return false if yield(element)}
      return true
    end

    if param.nil?
      my_each { |element| return false if element }
      return true
    end

    my_each { |element| return false if check_input_valid_by_critira(element, param) }
    true
  end

  def check_input_valid_by_critira(test_input, test_critira)
    if test_critira.is_a? Regexp
      !test_input.to_s.match(test_critira).nil?
    elsif test_critira.is_a? Class
      (test_input.class == test_critira)
    else
      (test_input == test_critira)
    end
  end
end
