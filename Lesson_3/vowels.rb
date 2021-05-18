alph = ('a'..'z')
vowels = ["a", "e", "i", "o", "u"]
hash = {}

alph_arr = []
alph.each do |l|
	alph_arr.push(l)
end


alph_arr.each do |key|
	if vowels.include?(key)
		hash[key] = alph_arr.index(key) + 1
	end
end

puts hash
