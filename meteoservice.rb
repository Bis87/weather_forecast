# Данные из метеосервиса http://www.meteoservice.ru/content/export.html

require 'net/http'
require 'uri'
require 'rexml/document'
require 'date'
require_relative 'meteo_method.rb'

CITIES = {'Moscow' => 37, 'Perm' => 59, 'St. Petersburg' => 69}

city_id = nil
# в цикле достаем город из словарика, пока юзер не ввел правильный город
until city_id
  puts "Enter city name"
  city_id = CITIES[STDIN.gets.chomp]
  puts "please, choose another city from the list #{puts CITIES.keys.to_s}" unless city_id
end



uri = URI.parse("http://xml.meteoservice.ru/export/gismeteo/point/#{city_id}.xml")

response = Net::HTTP.get_response(uri)

doc = REXML::Document.new(response.body)

city_name = URI.unescape(doc.root.elements['REPORT/TOWN'].attributes['sname'])


all_forecasts = doc.root.elements['REPORT/TOWN'].elements.to_a

i = 0

# puts all_forecasts[0]


puts "\n#{city_name}"

# while i < all_forecasts.length
#   current_forecast = doc.root.elements['REPORT/TOWN'].elements.to_a[i]
#   forecast(current_forecast)
#   i += 1
# end

all_forecasts.each {|el| forecast(el)}










