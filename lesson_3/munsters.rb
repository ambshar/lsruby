


ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

additional_ages = { "Marilyn" => 22, "Spot" => 237 }


def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size >= max_buffer_size
  buffer
end

output = []
buffer = [1,2,3]
max_buffer_size = 12

output = rolling_buffer1(buffer, max_buffer_size, 4)

p "buffer: #{buffer} output: #{output}"

output = []
buffer = [1,2,3]

output = rolling_buffer2(buffer, max_buffer_size, 4)

p "buffer: #{buffer} output: #{output}"


munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}



def find_age_group(age)
  case age
  when 0..17
    "kid"
  when 18..64
    "adult"
  else
    "senior"
  end
end


munsters.each do |key1, value1|
  value1["age_group"] = find_age_group(value1["age"])
end

p munsters

age = 0
munsters.each do |key1, value1|

  age += value1["age"] if value1["gender"] == 'male'
end

p age

munsters.each do |key1, value1|
  p "#{key1} is a #{value1["age"]} year old #{value1["gender"]}"
end
