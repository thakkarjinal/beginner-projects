require 'rubygems'
require 'selenium-webdriver'

driver = Selenium::WebDriver.for :firefox
driver.get "http://www.amazon.in"
puts driver.title
name_array = driver.find_elements(:css,"div.s9hl span.s9TitleText")
price_array = driver.find_elements(:css,"div.s9hl span.s9Price")
names = []
name_array.each do |name|
	names << name.text
end
names1 = names[0..2]
names2 = names[7..9]
names = names1.concat(names2)
#puts names
prices =[]
price_array.each do |price|
	prices<< price.text
end
prices1 = prices[0..2]
prices2 = prices[7..9]
prices = prices1.concat(prices2)
#puts prices
h={}
names.zip(prices) { |name,price| h[name.to_sym] = price }
puts h 