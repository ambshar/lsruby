# frozen_string_literal: true
require 'pry'
class Robot
  @all_names = []

  def name
    @name ||= generate_name
  end

  def generate_name
    name = alpha + numbers
    if Robot.all_names.include? name
      name = generate_name
    else
      Robot.all_names << name
    end
    name
  end

  def alpha
    Array('A'..'Z').sample + Array('A'..'Z').sample
  end

  def numbers
    ('000'..'999').to_a.sample
  end

  def self.all_names
    @all_names
  end


  def reset
    @name = nil
  end
end

r = Robot.new
puts r.name
