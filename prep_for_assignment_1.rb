
Select returns a new array based on the block's *return value*.  If the return value evaluates to true, then the element is selected.

for example putting puts in the block, returns nil (from puts) and hence the return array is an empty array.

select looks at the truthiness of the block to return the array elements.

arr.select do |n|
n+1
puts n
end


map is for transformation.  Changing the elements.

Map returns a new array based on the blocks *return value*.  Each element is transformed based on the return value
putting puts inside a map block will return an array of nils (see select above)

Return, side effects and output  -  this is what a code executes to.