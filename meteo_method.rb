require 'net/http'
require 'uri'
require 'rexml/document'
require 'date'

CLOUDINESS = {0 => 'clear', 1 => 'light cloudy', 2 => 'cloudy', 3 => 'Mainly cloudy'}

TIMEOFDAY = {0 => 'Night', 1 => 'Morning', 2 => 'Day', 3 => 'Evening'}


def forecast(node)

  time_of_day = node.attributes['tod'].to_i

  current_date = "#{node.attributes['day']}-#{node.attributes['month']}-#{node.attributes['year']}"

  min_temp =  node.elements['TEMPERATURE'].attributes['min']
  max_temp =  node.elements['TEMPERATURE'].attributes['max']

  max_wind = node.elements['WIND'].attributes['max']

  cloud_index = node.elements['PHENOMENA'].attributes['cloudiness'].to_i
  clouds = CLOUDINESS[cloud_index]

  if Date.parse(current_date).strftime('%d-%m-%Y') == Date.today.strftime('%d-%m-%Y')
    puts "\nToday, #{TIMEOFDAY[time_of_day]}"
  else
    puts "\ndate: #{current_date}, #{TIMEOFDAY[time_of_day]}"
  end

  puts "temperature: min: #{min_temp} max: #{max_temp}"

  puts "wind: #{max_wind} m/s"

  puts "cloudiness: #{clouds}"
end