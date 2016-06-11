require 'pry'
class Triangle

  def initialize(num)
    @num_rows = num
  end

  def rows
    result = [[1]]
    return result if @num_rows == 1

    current_row = result
    (2..@num_rows).each do |row|

      current_row = get_next_row(current_row)
      result << current_row
    end
    puts result

    result
    
  end

  def get_next_row(current_row)

    result = []
    current_row.each_with_index do |e, idx|
      if idx == 0
        result << 1
      else
        result << e + current_row[idx-1]
      end
    end
    result << 1
  

  end

  # def get_row(num)

  #   return [1] if num == 1
  #   return [1, 1] if num == 2
  #   output = [1]
  #   (1..(num-2)).each do |element|
  #     output << get_row(num-1)[element - 1] + get_row(num-1)[element]
  #   end
  #   output << 1

  # end

end