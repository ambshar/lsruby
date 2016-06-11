require 'pry'
class Triangle
  def initialize(hight)
    @hight = hight
    @current_row = []
  end

  def rows
    (1..@hight).map { @current_row = next_row }
  end

  private

  def next_row
    rest_of_row = @current_row.map.with_index do |left_number, index|
                    left_number + (@current_row[index + 1] || 0)
                  binding.pry
                  end
          binding.pry
    [1] + rest_of_row
  end
end