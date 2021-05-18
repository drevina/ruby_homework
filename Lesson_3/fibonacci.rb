arr = []

a = 0
b = 1
c = 1

loop do
	arr.push(a, b, c)
	a = b + c
	b = a + c
	c = a + b
break if a > 100 || b > 100 || c > 100
end

puts arr