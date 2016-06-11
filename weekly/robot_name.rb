require 'pry'
class Robot
  @@names = []

  def initialize
    @name = ''
  end

  def name
    return @name if @@names.include? @name

    loop do
      num = rand 100...1000
      alpha = Array('A'..'Z').sample + Array('A'..'Z').sample

      @name = alpha + num.to_s

      next if @@names.include? @name
      @@names << @name
    
      break
    end
    @name
  end

  def reset
    @@names.delete_if {|name| name == @name}
  end


end

