
puts "Введите день:"
day = gets.chomp.to_i

puts "Введите месяц:"
month = gets.chomp.to_i

puts "Введите год:"
year = gets.chomp.to_i

arr_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
day_number = 0


if month == 1
	day_number = day_number + day
else
	d = 0
	for d in 0..month - 2
  day_number += arr_months[d]
	end
	day_number = day_number + day
end

if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) 
	day_number += 1 if day_number > 59
end
 

puts "Этот день #{day_number} в году."