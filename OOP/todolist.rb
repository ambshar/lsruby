# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.
require 'pry'
class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end


class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo_item)
    raise TypeError, "Can only add Todo objects" unless todo_item.instance_of? Todo
    @todos << todo_item
  end
  alias :<< :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def done?
    @todos.all? {|todo| todo.done?}
  end

  def item_at(index)
    raise IndexError, "Number of items less than that requested" if index >= @todos.size 
    @todos[index]
  end

  def mark_done_at(index)
    raise IndexError, "No item at that index" if index >= @todos.size 
    @todos[index].done!
  end

  def mark_undone_at(index)
    raise IndexError, "No item at that index" if index >= @todos.size 
    @todos[index].undone!
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end


  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    raise IndexError, "No item at that index" if index >= @todos.size 
    @todos.delete_at(index)
  end


  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    output = TodoList.new(self.title)
    each do |todo|
      flag = yield(todo)
      output << todo if flag
    end
    output
  end

  def find_by_title(string)
    new_list = select {|todo| todo.title == string}
    new_list.size > 0 ? new_list.item_at(0) : nil
  end

  def all_done
    select { |todo| todo.done?}
  end

  def all_not_done
    select { |todo| !todo.done?}
  end

  def mark_done(string)
    each do |todo|
      if todo.title == string
        todo.done!
        break
      end
    end
  end

  def mark_all_done
    each { |todo| todo.done!}
  end

  def mark_all_undone
    each { |todo| todo.undone!}
  end
  
end


# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")
# list = TodoList.new("Today's Todos")




# list.add(todo1)                 # adds todo1 to end of list, returns list
# list.add(todo2)                 # adds todo2 to end of list, returns list
# list << (todo3)                 # adds todo3 to end of list, returns list
# #list.add(1)

# # p list.find_by_title("Go to gym")

# # todo2.done!

# # p list.all_done
# # p list.all_not_done

# # todo2.undone!

#  puts list.to_s
#  list.to_s2

#  list.mark_done("Go to gym")

#  puts list.to_s
# list.to_s2

# # list.mark_all_undone
# p list.to_s

# list.mark_all_done

# p list.to_s


# p list
# p list.size
# p list.first
# p list.last

# #list.item_at                    # raises ArgumentError
# p list.item_at(1)                 # returns 2nd item in list (zero based index)
# #p list.item_at(100)               # raises IndexError

# # ---- Marking items in the list -----

# # mark_done_at
# #p list.mark_done_at               # raises ArgumentError
# p list.mark_done_at(1)            # marks the 2nd item as done
# #p list.mark_done_at(100)          # raises IndexError

# p list

# # mark_undone_at
# #p list.mark_undone_at             # raises ArgumentError
# p list.mark_undone_at(1)          # marks the 2nd item as not done,
# #p list.mark_undone_at(100)        # raises IndexError

# # ---- Deleting from the the list -----

# # shift
# p list.shift                      # removes and returns the first item in list

# # pop
# p list.pop                        # removes and returns the last item in list

# p ""
# p list.size

# new_list = TodoList.new("Today's Todos")
# new_list.add(todo1)                 # adds todo1 to end of list, returns list
# new_list.add(todo2)                 # adds todo2 to end of list, returns list
# new_list << (todo3)                 # adds todo3 to end of list, returns list
# # remove_at
# #p list.remove_at                  # raises ArgumentError
# #p list.remove_at(1)               # removes and returns the 2nd item
#p list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
#new_list.to_s                      # returns string representation of the list



#new_list.to_s


# new_list.each do |todo|
#   puts todo
# end

# todo1.done!
# results = new_list.select { |todo| todo.done? }
# puts results.inspect

# result = new_list.each do |todo|
#   puts todo
# end

# p result

