class Vehicle

  attr_accessor :color
  attr_reader :year, :model

  @@number_vehicles = 0

  def self.number_of_vehicles
    puts "Vehicle class has created #{@@number_vehicles} vehicles"
  end

  

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@number_vehicles += 1
  end

  def self.mileage(gallons, miles)
    puts "#{miles/gallons} miles per gallon"
  end

  def speed_up(n)
    @speed += n
    puts "you sped up by #{n} mph"
  end

  def brake(n)
    @speed -= n
    puts "you slowed down by #{n} mph"
  end

  def speed
    puts "You are driving at #{@speed} mph"
  end
  
  def shut_down
    @speed = 0
    puts "You stopped"
  end

  def spray_paint(c)
    self.color = c
    puts "The new color of your vehicle is #{self.color}"
  end

  def to_s
    puts "This is a #{self.year} #{self.color} #{self.model} going at #{@speed}"
  end

  def age
    puts "#{self.model} age is #{get_age} years"
  end

  private

  def get_age
    Time.now.year - self.year.to_i
  end

end

module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  

  
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2
  
  

  
end

MyCar.mileage(14, 255)

car = MyCar.new("2009", 'silver', "highlander")
truck = MyTruck.new('2001', 'red', 'dodge ram')
p truck.can_tow? 2000


Vehicle.number_of_vehicles



puts car
puts truck
car.spray_paint "blue"
puts car

puts car.age
puts truck.age