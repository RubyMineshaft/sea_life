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

end
