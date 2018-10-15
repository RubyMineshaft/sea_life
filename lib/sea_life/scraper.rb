class SeaLife::Scraper

  BASE_URL = "https://oceana.org"

  def self.scrape_categories #Scrapes oceana and returns array of categories
    categories = []
    doc = Nokogiri::HTML(open(BASE_URL + "/marine-life"))
    doc.css("article.animal-tile").each do |item|
      category = {}
      category[:url] = item.css("div.overlay a").attribute("href").value
      category[:name] = item.css("div.copy h1").text
      categories << category
    end
    categories
  end

  # def self.scrape_animals(category_url)
  #   animals = []
  #   doc = Nokogiri::HTML(open(BASE_URL + category_url))
  #   doc.css("article").each do |animal|
  #     info = {}
  #     info[:url] = animal.css("div.overlay a").attribute("href").value
  #     info[:name] = animal.css("div.copy h1").text
  #   end
  # end
  def self.scrape_animals_from_url(url)
    doc = Nokogiri::HTML(open(BASE_URL + url))
    animal_info = {}
    binding.pry
    animal_info[:category] = doc.css("section.subpage-header div h2").text
    animal_info[:name] = doc.css("section.subpage-header div h1").text
    animal_info[:scientific_name] = doc.css("section.subpage-header div p").text
  end

end
