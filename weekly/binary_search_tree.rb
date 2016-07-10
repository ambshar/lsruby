require 'pry'

def record_all_data(bst)
    all_data = []
    bst.each { |data| all_data << data }
    all_data
  end

class Bst
  attr_reader :data
  attr_accessor :left, :right
  def initialize(number)
    @data = number
    @left = nil
    @right = nil
  end





  def insert(num)
    if num <= self.data
      return self.left = Bst.new(num) if self.left.nil?
      self.left.insert(num)
    else
      return self.right = Bst.new(num) if self.right.nil?
      self.right.insert(num)
    end
  end

  def each(&block)
    return enum_for(:each) unless block_given?
    self.left.each(&block) if self.left
    block.call(self.data)
    self.right.each(&block) if self.right

  end


end

four = Bst.new 4

p four.data
four.insert 2

four.insert 6

p record_all_data(four)
