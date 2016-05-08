contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}


contacts.each do |k, v|

  contacts[k][:email] = contact_data.first.shift
  contacts[k][:address] = contact_data.first.shift
  contacts[k][:phone] = contact_data.first.shift
  
  contact_data.shift #takes out the first entry in the array which is now empty [[], ["sally@email, ...etc"]]

end

puts contacts

puts contacts["Joe Smith"][:email]

puts contacts["Sally Johnson"][:phone]



