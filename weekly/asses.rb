


  class Employee
    VACATION = {executive: 20, manager: 14, regular: 10, part_time: 0}
    LOCATION = {executive: "corner office", manager: "private office", 
                 regular: "cubicle", part_time: "open workspace"}

    attr_accessor :name, :serial, :type
    attr_reader :vacation, :location
    def initialize(name, serial, fulltime = true)
      
      @serial = serial
      @type = :part_time if fulltime == false
      @vacation = VACATION[@type]
      @location = LOCATION[@type]
      @name = prefix + name

    end

    def can_delegate?
      return true if (self.type == :manager || self.type == :executive)
      false  
    end

    def prefix
      case self.type
      when :executive
            "Exe "
      when :manager
         "Mgr "
      else
        ''
      end
    end

    def to_s
      prefix + self.name

    end

  end #end Employee

  class Manager < Employee
    def initialize(name, serial, fulltime = true)
      @type = :manager
      super
    end

  end

  class Executive < Employee
    def initialize(name, serial, fulltime = true)
      @type = :executive
      super
    end

  end

  class Regular < Employee
    def initialize(name, serial, fulltime = true)
      @type = :regular
      super
    end


  end

m = Manager.new("adam", 2)
p = Employee.new("eve", 3, false)

puts m.type, m.can_delegate?, m.vacation
puts p.type, p.can_delegate?, p.vacation
puts m.name, p.name
