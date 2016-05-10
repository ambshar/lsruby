require 'pry'

def prompt(message)
  puts("=> #{message}")
end

def integer?(number)
  number.to_i.to_s == number
end

def float?(number)
  Float(number) rescue false # method similar to integer? doesn't work when input string is ".1"
end

def number?(number)
  integer?(number) || float?(number)
end

def monthly_calculator(amt, apr, duration)
  apr /= 1200 # monthly % is divided by 100.  5% becomes 0.05.  divided by 12 to find monthly rate
  duration *= 12 # convert years to months

  parenthesis = (1 + apr)**duration

  if apr > 0
    amt * (apr * parenthesis) / (parenthesis - 1)
  else
    amt / duration
  end
end

prompt "Welcome to mortgage calculator."

prompt "Please enter the following information to calculate your monthly payment"

prompt "Enter Loan Amount in $"
amount = '' # initialize outside the loop
loop do
  amount = gets.chomp

  if number?(amount) && amount.to_f > 0
    amount = amount.to_f
    break
  else
    prompt "Invalid amount"
  end
end

prompt " What is the Annual Percentage rate APR %?"
apr = ''
loop do
  apr = gets.chomp

  if number?(apr) && apr.to_f >= 0
    apr = apr.to_f
    break
  else
    prompt "Invalid APR"
  end
end

prompt "What is the length of the loan in years"

duration = ''
loop do
  duration = gets.chomp

  if number?(duration) && duration.to_f > 0
    duration = duration.to_f
    break
  else
    prompt "Invalid length of loan"
  end
end

monthly = monthly_calculator(amount, apr, duration)

prompt "Monthly payment is $#{monthly.round(2)} over #{duration * 12} months"
