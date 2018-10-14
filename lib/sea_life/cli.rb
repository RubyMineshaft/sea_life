class SeaLife::CLI

  def call
    puts <<-DOC
------------------------------------------------
                  SeaLife
------------------------------------------------

Welcome to Sea Life!
DOC
    make_categories
    list_categories
  end

  def list_categories
    puts ""
    puts "Please choose a category to learn about:"
    puts ""
    @categories = SeaLife::Category.all
    @categories.each_with_index do |category, i|
      puts "#{i + 1}. #{category.name}"
    end
    puts ""
  end

  def make_categories
    SeaLife::Scraper.scrape_categories.each do |category|
      SeaLife::Category.new(category)
    end
  end

end
