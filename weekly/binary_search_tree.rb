
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
