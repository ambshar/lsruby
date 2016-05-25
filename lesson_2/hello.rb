
PROD = [{p: 300, q: 'thinkpad'}, {p: 200, q: 'thinkpad'}, {p: 200, q: 'dell'}, {p: 450, q: 'thinkpad'}]




def search(query)
  min = query[:pmin]
  max = query[:pmax]
  type = query[:brand]
  out = []
 PROD.select do |e|
    e[:p] <= max && e[:p] >= min && e[:q] == type.downcase
  end
  
end



out = []
q = {pmin: 200, pmax: 500, brand: 'Dell'}

p search(q)
