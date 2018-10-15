class SeaLife::CLI

  def call
    puts <<-DOC
------------------------------------------------
                  SeaLife
------------------------------------------------

Welcome to Sea Life!
DOC

    list_categories

  end

  def list_categories
    puts ""
    puts "Please choose a category to learn about:"
    puts ""
    make_categories if SeaLife::Category.all.size == 0
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

  def list_animals(category)
    puts "Loading animals..."
    puts ""
    make_animals_from_category(category) if category.animals.size == 0
    puts "Please select the animal you'd like to learn about:"
    category.animals.each_with_index do |animal, i|
      puts "#{i + 1}. #{animal.name}"
    end
  end

  def make_animals_from_category(category)
    SeaLife::Scraper.scrape_animals(SeaLife::Category.find_by_name(category).url)
  end

end
