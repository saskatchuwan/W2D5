class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
      self.each_with_index do |num, i|
        result += (num.hash).to_f / (i.hash).to_f
      end
    result.to_i
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a

    arr = self.split("")
    result = []

    arr.each do |ch|
      result << alphabet.index(ch)
    end

    result.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    alphabet = ("a".."z").to_a

    arr = self.to_a
    arr_strings = arr.each {|pair| pair.map! { |el| el.to_s }}
    arr_nums = arr_strings.each {|pair| pair.map! {|el| alphabet.index(el)}}

    sum = 0
    arr_nums.each do |pair|
      sum += pair[0].hash.fdiv(pair[1].hash)  
    end
    sum.to_i 
  end
end
