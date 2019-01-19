class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key.hash)
      if @count < num_buckets 
        self[key.hash] << key 
      else 
        resize!
        self[key.hash] << key
      end

      @count += 1
    end
  end

  def include?(key)
    @store.each do |bucket|
      return true if bucket.include?(key)
    end
    false
  end

  def remove(key)
    if include?(key)
      @store.each do |bucket|
        bucket.reject!{|el| el == key}
      end
      @count -= 1
    else
    end
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
        new_store[el.hash % new_store.length] << el
      end
    end

    @store = new_store

  end
end
