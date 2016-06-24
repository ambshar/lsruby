require 'pry'
class Atbash
  @code_key = {}

  def self.encode(string)
    make_code_key
    string_array = string.downcase.scan(/[a-z0-9]/)

    output = []

    string_array.each do |chr|
      output << (chr.to_i == 0 ? @code_key[chr] : chr)
    end

    output.join.scan(/.{1,5}/).join(" ")
  end

  def self.make_code_key
    key = ("a".."z").to_a
    value = key.reverse

    key.each_with_index { |k, idx| @code_key[k] = value[idx] }
  end
end
