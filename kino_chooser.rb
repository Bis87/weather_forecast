require 'mechanize'

agent = Mechanize.new()

film_title = nil

choosen = false

until choosen
  page = agent.get("http://www.kinopoisk.ru/top/lists/1/filtr/all/sort/order/perpage/100/page/#{rand(5)}/")

  tr_tag = page.search("//tr[starts-with(@id, 'tr_')]").to_a.sample

  title = tr_tag.search("a[@class = 'all']").text
  rating = tr_tag.search("span[@class = 'all']").text
  link = "https://www.kinopoisk.ru/film/#{tr_tag.attributes['id']}/"
  description = tr_tag.search("span[@class = 'gray_text']")[0].text
end