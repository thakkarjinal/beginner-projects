require 'rubygems'
require 'nokogiri' 
require 'open-uri'
while 1
	puts "Enter the number of movies"
	no_of_movies = gets.chomp.to_i
	if no_of_movies > 250
		puts "The number should not exceed 250"
		next
	else 

		break
	end
end
link = "http://www.imdb.com/chart/top?ref_=nv_ch_250_4"
doc = Nokogiri::HTML(open(link))
hash = Hash.new ([])
movie_list = doc.css('tbody.lister-list tr td.titleColumn a')
doc_new = Nokogiri::HTML(open("http://www.imdb.com"+movie_list[0].attribute("href")))
stars =  doc_new.css('table.cast_list tr td.itemprop a')
star_array=[]
		for star in stars
			star_array << star.text.strip.downcase
		end
hash[movie_list[0].text] = star_array

doc_new = Nokogiri::HTML(open("http://www.imdb.com"+movie_list[1].attribute("href")))
stars =  doc_new.css('table.cast_list tr td.itemprop a')
star_array=[]
		for star in stars
			star_array << star.text.strip.downcase
		end
hash[movie_list[1].text] = star_array


puts "enter the star"
input_star = gets.chomp.downcase
not_acted = no_of_movies
	hash.values.each do |value|
		if value.include?(input_star)
			puts "the actor has worked in #{hash.key(value)},"
			no_of_movies -= 1
		else
			no_of_movies -= 1
			not_acted -= 1
		end
	
	end
if no_of_movies == not_acted
	puts "the actor has not acted in any movie"
end