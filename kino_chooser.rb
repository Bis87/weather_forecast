require 'mechanize'
require 'launchy'
require 'openssl'

agent = Mechanize.new()

choosen = false


# puts OpenSSL::OPENSSL_VERSION
# puts "SSL_CERT_FILE: %s" % OpenSSL::X509::DEFAULT_CERT_FILE
# puts "SSL_CERT_DIR: %s" % OpenSSL::X509::DEFAULT_CERT_DIR




until choosen

  begin
  page = agent.get("http://www.kinopoisk.ru/top/lists/1/filtr/all/sort/order/perpage/100/page/#{rand(5)}/")
  rescue SocketError => e
    puts 'Check your internet connection'
    abort e.message
  end

  tr_tag = page.search("//tr[starts-with(@id, 'tr_')]").to_a.sample

  title = tr_tag.search("a[@class = 'all']").text
  rating = tr_tag.search("span[@class = 'all']").text


  id = /\d+/.match(tr_tag.attributes['id'])

  kinopoisk_link = "https://www.kinopoisk.ru/film/#{id}/"

  # rutracker_link = "http://rutracker.org/forum/viewforum.php?f=7"
  rutracker_link = "http://rutracker.org/forum/tracker.php?nm=#{title}"

  description = tr_tag.search("span[@class = 'gray_text']")[0].text

  puts title
  puts description
  puts "kinopoisk rating:#{rating}"

  puts "this one? (Y/N)"

  choice = STDIN.gets.chomp

  if choice.downcase == 'y'
    choosen = true
  end
end

if choice.downcase == 'y'
  puts 'Which page open?'
  puts '1. Film`s page on kinopoisk'
  puts '2. Find film on rutracker(authorisation required)'

  choice = STDIN.gets.chomp.to_i


  url = case choice
    when 1 then kinopoisk_link
    when 2 then rutracker_link
        end

    Launchy.open(url)

end