# Данные из метеосервиса http://www.meteoservice.ru/content/export.html

require 'net/http'
require 'uri'
require 'rexml/document'

#словарик для cloudiness
CLOUDINESS = {0 => 'clear', 1 => 'light cloudy', 2 => 'cloudy', 3 => 'Mainly cloudy'}

uri = URI.parse('http://xml.meteoservice.ru/export/gismeteo/point/34.xml')

response = Net::HTTP.get_response(uri)

doc = REXML::Document.new(response.body)

city_name = URI.unescape(doc.root.elements['REPORT/TOWN'].attributes['sname'])

current_forecast = doc.root.elements['REPORT/TOWN'].elements.to_a[0]

min_temp =  current_forecast.elements['TEMPERATURE'].attributes['min']
max_temp =  current_forecast.elements['TEMPERATURE'].attributes['max']

max_wind = current_forecast.elements['WIND'].attributes['max']

cloud_index = current_forecast.elements['PHENOMENA'].attributes['cloudiness'].to_i
clouds = CLOUDINESS[cloud_index]

puts city_name

puts "temperature: min: #{min_temp} max: #{max_temp}"

puts "wind: #{max_wind} m/s"

puts "cloudiness: #{clouds}"

