arr = []

a = 0
b = 1
c = 1

loop do
	arr.push(a, b, c)
	a = b + c
	b = a + c
	c = a + b
break if a > 2000 || b > 2000|| c > 2000
end

puts arr