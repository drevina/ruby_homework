puts "Введите три коэффициента:"
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i

D = ((b**2) - (4*a*c))

if D > 0
	x1 = (-b + Math.sqrt(D))
	x2 = (-b - Math.sqrt(D))
	puts "Дискриминант: #{D}, корни уравнения: #{x1} и #{x2}."
elsif D == 0
	x = -b/(2*a)
	puts "Дискриминант: #{D}, корень уравнения: #{x}."
else
	puts "Дискриминант: #{D}. Корней нет."
end