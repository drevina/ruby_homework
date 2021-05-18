purchases = {}

loop do
  puts "Введите название товара или stop, чтобы завершить ввод:"
  name = gets.chomp
  break if name == "stop"

  puts "Введите цену за единицу товара:"
  price = gets.to_f
  puts "Введите кол-во товара:"
  amount = gets.to_f
  purchases[name] = {price: price, amount: amount}
end

puts purchases
sum = 0
purchases.each do |product, info|
  total = info[:price] * info[:amount]
  puts "Вы купили #{product} на сумму #{total}"
  sum += total
end
puts "Общая сумма покупок: #{sum}. Ждём Вас снова! :)"