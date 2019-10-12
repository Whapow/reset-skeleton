# -*- ruby encoding: utf-8 -*-

class Reset
  VERSION = '1.0.0'

  def initialize(array = [])
    @set = array.uniq
  end

  def set
    @set
  end

  def add(value)
    @set.push(value) unless @set.include?(value)
  end

  def remove(value)
    @set.delete(value) if @set.include?(value)
  end

  def print
    "{ #{@set.join(', ')} }"
  end

  def contains?(value)
    @set.include?(value)
  end

  def empty?
    @set.empty?
  end

  def number_of_elements?
    @set.size
  end

  def union(reset)
    raise ArgumentError.new("Must be a Reset") unless reset.is_a?(Reset)
    u = @set.to_a
    reset.set.each do |i|
      u.push(i) unless self.contains?(i)
    end
    Reset.new(u)
  end
  
  def intersection(reset)
    raise ArgumentError.new("Must be a Reset") unless reset.is_a?(Reset)
    n = []
    reset.set.each do |i|
      n.push(i) if self.contains?(i)
    end
    Reset.new(n)
  end
  
  def difference(reset)
    raise ArgumentError.new("Must be a Reset") unless reset.is_a?(Reset)
    d = []
    @set.each do |i|
      d.push(i) unless reset.contains?(i)
    end
    Reset.new(d)
  end
  
  def has_subset?(reset)
    raise ArgumentError.new("Must be a Reset") unless reset.is_a?(Reset)
    reset.set.each do |i|
      return false unless self.contains?(i)
    end
    true
  end

  def subset_of?(reset)
    raise ArgumentError.new("Must be a Reset") unless reset.is_a?(Reset)
    @set.each do |i|
      return false unless reset.contains?(i)
    end
    true
  end

end
