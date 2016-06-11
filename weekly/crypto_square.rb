# frozen_string_literal: true
require 'pry'

class Crypto
  attr_reader :text

  def initialize(string)
    @text = string.downcase.gsub(/[^a-z0-9]/i, '')
    raise TypeError, "No empty strings" if text.strip.empty?
    
    @len = size
  end

  def size
    Math.sqrt(text.length).ceil
  end

  def plaintext_segments
   
      @split_text = text.scan(/.{1,#{size}}/)
    
  end

  def ciphertext
    encode_plaintext
  end

  def encode_plaintext(delimiter='')
    padded_segments = plaintext_segments.map {|string| string_to_a(string, size)}
    padded_segments.transpose.map(&:join).join(delimiter)
 
  end

  def normalize_ciphertext
    encode_plaintext(' ')
  end

  def string_to_a(string, size_limit)
    result = string.chars
     (size_limit - string.size).times {result << nil} if string.size < size_limit

    result
  end

  # def new_text
  #   counter = 0
  #   result = []

  #   plaintext_segments

  #   @len.times do
  #     result << @split_text.map { |e| e[counter] }.join
  #     counter += 1
  #   end
  #   result
  # end

  # def output
  #   puts "Normalized text: #{text}"
  #   puts ""
  #   ciphertext
  #   normalize_ciphertext
  #   result = new_text

  #   puts "Making square"
  #   @split_text.each { |e| puts e }

  #   puts "Making square code"
  #   puts result.join(" ")
  # end

  def normalize_plaintext
    @text
  end
end # end crypto

new_crypto = Crypto.new('Madness, and then illumination.')


