class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(n, g)

    self.name = n
    self.grade = g
  end

  def better_grade_than?(student_name)

    self.grade > student_name.grade

  end

  protected

  def grade
    @grade
  end

end

jim = Student.new("Jim", 78)
bob = Student.new("Bob", 65)

puts "Well done" if jim.better_grade_than? bob

puts jim.name