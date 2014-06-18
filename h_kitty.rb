array = []
while 1
	input = gets.chomp
	if input == '.'
		break
	else
		array << input
	end
end
array.each do |pair|
	pair = pair.split(' ')
	word = pair[0]
	number = pair[1].to_i
	while number != 0
		print word
		number -= 1
	end
end
#print word.split("").rotate.join("")