require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max){false}
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num] == true
    false
  end

  private

  def is_valid?(num)
    return true if num > @store.length || num < 0
    false
  end

  def validate!(num)
    #we don't know what to do with this.
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].reject! { |el| el == num }
  end

  def include?(num)
    return true if self[num].include?(num)
    false 
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    #Still needs to account for if element already exist
    unless include?(num)
      if @count < num_buckets 
        self[num] << num 
      else 
        resize!
        self[num] << num 
      end

      @count += 1
    end

  end

  def remove(num)
    if include?(num)
      @store.each do |bucket|
        bucket.reject!{|el| el == num}
      end
      @count -= 1
    else
    end

  end

  def include?(num)
    @store.each do |bucket|
      return true if bucket.include?(num)
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { Array.new }

    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_store.length] << el
      end
    end

    @store = new_store

  end
end

