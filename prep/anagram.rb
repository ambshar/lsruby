words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']


  hash = {}

  words.each do |e|
    key = e.split(//).sort.join

    if hash.has_key?(key)
      hash[key].push(e)
    else
      hash[key] = [e]
    end

  end

  
  hash.each do |k, v|
    p v

  end