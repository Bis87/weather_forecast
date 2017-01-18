# Данные из метеосервиса http://www.meteoservice.ru/content/export.html

require 'net/http'
require 'uri'
require 'rexml/document'
require 'date'

#словарик для cloudiness
CLOUDINESS = {0 => 'clear', 1 => 'light cloudy', 2 => 'cloudy', 3 => 'Mainly cloudy'}

uri = URI.parse('http://xml.meteoservice.ru/export/gismeteo/point/34.xml')

response = Net::HTTP.get_response(uri)

doc = REXML::Document.new(response.body)

city_name = URI.unescape(doc.root.elements['REPORT/TOWN'].attributes['sname'])


all_forecasts = doc.root.elements['REPORT/TOWN'].elements.to_a

i = 0

puts all_forecasts[0]

while i < all_forecasts.length

  current_forecast = doc.root.elements['REPORT/TOWN'].elements.to_a[i]

  current_date = "#{current_forecast.attributes['day']}-#{current_forecast.attributes['month']}-#{current_forecast.attributes['year']}"

  min_temp =  current_forecast.elements['TEMPERATURE'].attributes['min']
  max_temp =  current_forecast.elements['TEMPERATURE'].attributes['max']

  max_wind = current_forecast.elements['WIND'].attributes['max']

  cloud_index = current_forecast.elements['PHENOMENA'].attributes['cloudiness'].to_i
  clouds = CLOUDINESS[cloud_index]

  if Date.parse(current_date).strftime('%d-%m-%Y') == Date.today.strftime('%d-%m-%Y')
    puts "Today"
  else
    puts "date: #{current_date}"
  end


  puts "temperature: min: #{min_temp} max: #{max_temp}"

  puts "wind: #{max_wind} m/s"

  puts "cloudiness: #{clouds}"

  i += 1

end








