require 'pry'

class GoodDog
  DOG_YEARS = 7
  attr_accessor :name, :height, :weight, :age

  @@number_of_dogs = 0

  def self.who_am_i
    puts "I am the GoodDog class"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
  
  def initialize(n, h, w, a)
    self.name = n
    self.height = h
    self.weight = w
    self.age = a * DOG_YEARS
    @@number_of_dogs += 1
  end
  
  def speak
    "Arf!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def to_s
    puts "This dog's name is #{self.name} and age is #{self.age} in human years"
  end

  def what_is_self
    self
  end

end  # end GoodDog Class

puts GoodDog.total_number_of_dogs

sparky = GoodDog.new('Sparky', '20 in', '15 lbs', 4)
GoodDog.new("new dog", "14 in", "44 lbs", 7)
puts GoodDog.who_am_i
puts GoodDog.total_number_of_dogs
puts sparky.speak
puts sparky.name
puts sparky.info
sparky.change_info("Spartacus", "12 in", "30 lbs")
puts sparky.info
puts sparky
p sparky