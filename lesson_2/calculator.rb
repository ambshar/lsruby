
require 'pry'
require 'yaml'
LANGUAGE = 'en'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  #message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def valid_number?(number)
  number.to_i != 0
end

def is_integer?(number)
  number.to_i.to_s == number
end

def is_float?(number)
  number.to_f.to_s == number
end

def number?(number)
  is_integer?(number) || is_float?(number)
end

def operation_to_message(oper)
  case oper
  when '1'
    "Adding"
  when '2'
    "Subtracting"
  when '3'
    "Multiplying"
  when '4'
    "Dividing"
  end
end

prompt messages('welcome',LANGUAGE)

name = ''

loop do
  name = gets.chomp

  if name.empty?
    prompt messages('valid_name', LANGUAGE)
  else
    break
  end
end

prompt(messages('greeting', LANGUAGE) + name)

loop do # main loop
  a = ''  # initialize outside the loop
  loop do
    prompt messages('first_number', LANGUAGE)

    a = gets.chomp

    if number?(a)
      a = a.to_f
      break
    else
      prompt messages('invalid_number', LANGUAGE) 
    end
  end

  b = ''  # initialize outside the loop
  loop do
    prompt messages('second_number', LANGUAGE)
    b = gets.chomp

    if number?(b)
      b = b.to_f
      break
    else
      prompt messages('invalid_number', LANGUAGE)
    end
  end

  operator_prompt = messages('operation', LANGUAGE)
  #binding.pry
  
  prompt(operator_prompt)

  oper = ''
  loop do
    oper = gets.chomp

    if %w(1 2 3 4).include?(oper)
      break
    else
      prompt messages('invalid_operator', LANGUAGE)
    end
  end

  prompt("#{operation_to_message(oper)} the numbers...")
  sleep 1

  answer = case oper
           when '1'
             a + b
           when '2'
             a - b
           when '3'
             a * b
           when '4'
             a.to_f / b.to_f
           end

  prompt "Answer is #{answer}" if answer

  prompt messages('ask_again', LANGUAGE)

  response = gets.chomp

  if response.downcase.start_with?('y')
    next
  else
    break
  end
end # main

prompt messages('sign_off', LANGUAGE) + name
