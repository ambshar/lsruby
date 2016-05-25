require 'pry'
class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_full_name(name)
  end

  def name
    "#{self.first_name} #{self.last_name}".strip
  end

  def name=(n)
    parse_full_name(n)
  end

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    name_arr = full_name.split

    self.first_name = name_arr.first
    self.last_name = name_arr.size > 1 ? name_arr.last : ""
  end

end


bob = Person.new("Robert Smith")
rob = Person.new("Robert Smith")

p bob.name
p bob.first_name
p bob.last_name
# bob.last_name = 'Smith'
# p bob.name

# bob.name = "John"
# p bob.first_name
# p bob.last_name
# p bob.name

p bob.name == rob.name

puts "The person's name is: #{bob}"

