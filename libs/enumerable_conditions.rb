# frozen_string_literal: true

module Enumerable
  def my_all(param = nil)
    if block_given?
      my_each { |element| return false if yield(element) == false }
      true
    end

    if param.nil?
      my_each { |element| return false unless element }
      true
    end

    if param.is_a? Regexp
      my_each { |element| return false if element.to_s.match(param).nil? }
      true
    end

    if param.is_a? Class
      my_each { |element| return false if element.class != param }
      true
    end

    unless param.nil?
      my_each { |element| return false if (element == param) == false }
      true
    end
  end

  def my_any(param = nil)
    if block_given?
      my_each { |element| return true if yield(element) == true }
      false
    elsif param.nil?
      my_each { |element| return true if element }
      false
    elsif param.is_a? Regexp
      my_each { |element| return true unless element.to_s.match(param).nil? }
      false
    elsif param.is_a? Class
      my_each { |element| return true if element.class == param }
      false
    elsif !param.nil?
      my_each { |element| return true if (element == param) == true }
      false
    end
  end

  def my_none(param = nil)
    if block_given?
      my_each { |element| return false if yield(element) == true }
      true
    elsif param.nil?
      my_each { |element| return false if element }
      true
    elsif param.is_a? Regexp
      my_each { |element| return false unless element.to_s.match(param).nil? }
      true
    elsif param.is_a? Class
      my_each { |element| return false if element.class == param }
      true
    elsif !param.nil?
      my_each { |element| return false if (element == param) == true }
      true
    end
  end
end
