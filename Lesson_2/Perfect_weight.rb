puts "Введите Ваше имя:"
name = gets.chomp

puts "Введите Ваш рост в сантиметрах:"
height = gets.chomp

perfect_weight = (height.to_i - 110) * 1.15

if perfect_weight > 0
	puts "#{name}, Ваш идеальный вес ~ #{perfect_weight}."
else
	puts "#{name} - Ваш вес уже оптимальный!"
end