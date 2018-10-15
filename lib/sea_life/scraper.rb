class SeaLife::Scraper

  BASE_URL = "https://oceana.org"

  def self.scrape_categories #Scrapes oceana and returns array of categories
    categories = []
    doc = Nokogiri::HTML(open(BASE_URL + "/marine-life"))
    doc.css("article.animal-tile").each do |item|
      category = {}
      category[:url] = item.css("div.overlay a").attribute("href").value
      category[:name] = item.css("div.copy h1").text
      categories << category unless category[:name] == "Marine Science and Ecosystems"
    end
    categories
  end

  def self.scrape_animals(category_url)
    doc = Nokogiri::HTML(open(BASE_URL + category_url))
    doc.css("article").each do |animal|
     SeaLife::Animal.new(SeaLife::Scraper.scrape_animals_from_url("#{animal.css("div.overlay a").attribute("href").value}"))
    end
  end

  def self.scrape_animals_from_url(url)
    doc = Nokogiri::HTML(open(BASE_URL + url))
    animal_info = {}
    animal_info[:category] = doc.css("section.subpage-header div h2").text
    animal_info[:name] = doc.css("section.subpage-header div h1").text
    animal_info[:scientific_name] = doc.css("section.subpage-header div p").text
    animal_info[:short_desc] = doc.css("div.animal-description-contain p").text
    # j = 1
    # p_size = doc.css("section.animal-secondary div.flex-item-2 p").size
    # until j == p_size - 6 do
    #
    # end
    animal_info[:longer_desc] = doc.css("section.animal-secondary div.flex-item-2 p").text
    i = 0
    while i < doc.css("div.animal-details-side h2").size - 1 do
      info_cat = doc.css("div.animal-details-side h2")[i].text.strip.downcase
      info = doc.css("div.animal-details-side p")[i].text.strip
      case info_cat
      when "ecosystem/habitat"
        animal_info[:habitat] = info
      when "feeding habits"
        animal_info[:habits] = info
      when "conservation status"
        animal_info[:status] = info
      else
        animal_info[info_cat.to_sym] = info
      end

      i += 1
    end
    animal_info
  end

end
