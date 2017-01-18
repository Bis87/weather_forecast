require 'net/http'
require 'uri'
require 'rexml/document'
require 'date'

uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")

response = Net::HTTP.get_response(uri)

doc = REXML::Document.new(response.body)

doc.each_element('//Valute[@ID = "R01235" or @ID = "R01239"]') do |el|

  name = el.get_text('Name')
  value = el.get_text('Value')

  puts "#{name}: #{value} руб."
end
