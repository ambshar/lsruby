require 'pry'
class WordProblem
  

  def initialize(problem)
    @problem = problem
  end

  def answer
    replace_operators
    
    
    @problem.slice!(0..7)
   
    @problem.slice!(-1) 
    problem = @problem.split(" ")
    
    operands = problem.select.each_with_index {|e, idx| idx.even?}
    operator = problem.select.each_with_index {|e, idx| idx.odd?}
    #problem.slice!(-1) ["1", "+", "2"]
    acc = operands[0].to_i
    (1...operands.size).each do |idx|

      acc = acc.send operator[idx-1], operands[idx].to_i 
  
    end
    acc
    
  end

  def replace_operators
    @problem.gsub! "plus", "+"
    @problem.gsub! "minus", "-"
    @problem.gsub! "multiplied by", "*"
    @problem.gsub! "divided by", "/"
    raise ArgumentError, "No Operators" if @problem.scan(/[*+-\/]/).empty?
  
  end
end

"What is 1 plus 1 minus 3 multiplied by 4 divided by 7 plus 3"

problem = WordProblem.new("What is 55 plus 3?")
problem.answer