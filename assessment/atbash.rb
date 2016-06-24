require 'pry'
class Atbash
  KEYS = ("a".."z").to_a
  VALUES = KEYS.reverse
  CODE_KEY = Hash[KEYS.zip(VALUES)]

  def self.encode(string)
    string_array = string.downcase.scan(/[a-z0-9]/)

    #output = []

    result = string_array.each_with_object([]) do |chr, output|
      output << (chr.to_i == 0 ? CODE_KEY[chr] : chr)
    end

    result.join.scan(/.{1,5}/).join(" ")
    binding.pry
  end
end

p Atbash.encode("the whole 45 thing@ is that...")
