require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'
SimpleCov.start
MiniTest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test

def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
  end

  def test_done?
    @todo1.done!
    @todo2.done!
    @todo3.done!
    assert(@list)
  end

  def test_raise_TypeError
    assert_raises(TypeError) do
      @list.add 3
    end
  end

  def test_add_alias
    new_todo = Todo.new("Water plants")
    @list.add(new_todo)
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) do
      @list.item_at 3
    end

    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done_at
    assert_raises(IndexError) {@list.mark_done_at(5)}
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(10)}
    @list.mark_done_at(1)
    @list.mark_undone_at(1)
    assert_equal(false, @todo2.done?)

  end

  def test_done!
    @list.done!
    @list.each do |todo|
      assert_equal(true, todo.done?)
    end
  end

  def test_remove_at
    assert_raises(IndexError) {@list.remove_at(5)}
    @list.remove_at(0)
    assert_equal(@todo2, @list.first)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    

  end

  def test_to_s_2
    @list.mark_done_at(0)

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    @list.mark_all_done

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

  end

  def test_each
    counter = 0
    @list.each {|todo| counter += 1}

    assert_equal(3, counter)

  end

  def test_each_2
    result = @list.each {|todo| 1}

    assert_equal(@list, result)
  end

  

  def test_select
    @list.mark_done_at(1)
    result = @list.select{|todo| todo.done?}
    assert_equal(@list.item_at(1), result.item_at(0))
  end

  def test_find_by_title
    title = "Go to gym"
    assert_equal(@list.find_by_title(title), @todo3)
  end

  def test_all_done
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)
    assert_equal(list.to_s, @list.all_done.to_s)
  end

  def test_all_done
    @todo1.done!
    @todo2.done!
    list = TodoList.new(@list.title)
    list.add(@todo3)
    assert_equal(list.to_s, @list.all_not_done.to_s)
  end

end

class TodoTest < MiniTest::Test

  def setup
    @todo = Todo.new("Buy milk")
  end

  def test_done!
    @todo.done!

    assert_equal(true, @todo.done)
  end
end