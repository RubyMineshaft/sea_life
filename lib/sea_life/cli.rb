class SeaLife::CLI

  def call
    puts "------------------------------------------------------------"
    puts ""
    puts "      _________             .____    .__  _____"
    puts "     /   _____/ ____ _____  |    |   |__|/ ____\\____"
    puts "     \\_____  \\_/ __ \\\\__  \\ |    |   |  \\   __\\/ __ \\"
    puts "     /        \\  ___/ / __ \\|    |___|  ||  | \\  ___/"
    puts "    /_________/\\____/ _____/ ________\\__||__|  \\____/"
    puts ""
    puts ""
    puts "------------------------------------------------------------"
    puts ""
    puts "Welcome!"

    list_categories
  end

  def list_categories
    puts ""
    puts "Please choose a category to learn about:"
    puts ""

    make_categories if SeaLife::Category.all.size == 0
    categories = SeaLife::Category.all

    categories.each_with_index do |category, i|
      puts "#{i + 1}. #{category.name}"
    end

    puts ""
    main_menu(categories)
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
    puts ""

    category_menu(category.animals)
  end


  def make_animals_from_category(category)
    SeaLife::Scraper.scrape_animals(category)
  end

  def show_animal(animal)
    SeaLife::Scraper.scrape_animal_info(animal) unless animal.scientific_name

    puts ""
    puts "--------------------------------------------------------------"
    puts "#{animal.name} (#{animal.scientific_name})"
    puts ""
    puts "Distribution:  #{animal.distribution}"
    puts "Ecosystem/Habitat: #{animal.habitat}"
    puts "Feeding Habits: #{animal.habits}"
    puts "Conservation Status: #{animal.status}"
    puts "Taxonomy: #{animal.taxonomy}"
    puts "--------------------------------------------------------------"
    puts ""
    puts "#{animal.short_desc}"
    puts ""
    puts "Enter \"MORE\" to continue reading about the #{animal.name}."
    puts "You may also enter \"BACK\", \"MENU\", or \"EXIT\"."

    animal_menu(animal)
  end

  def animal_menu(animal)
    input = gets.strip.downcase

    if input == "more"
      puts ""
      puts "#{animal.longer_desc}"
      puts ""
      puts "Please enter BACK, MENU, or EXIT."
      animal_menu(animal)
    elsif input == "back"
      list_animals(animal.category)
    elsif input == "menu"
      list_categories
    elsif input == "exit"
      goodbye
    else
      puts "Invalid input. Please enter MORE, BACK, MENU, or EXIT."
      animal_menu(animal)
    end
  end

  def main_menu(categories)
    puts "Please enter the number of a category:"
    puts "You may also enter \"SEARCH\" or \"EXIT\"."

    input = gets.strip

    if input.to_i > 0 && input.to_i <= categories.size
      list_animals(categories[input.to_i - 1])
    elsif input.downcase == "search"
      search_by_name
    elsif input.downcase == "exit"
      goodbye
    else
      puts "Invalid input."
      main_menu(categories)
    end
  end

  def category_menu(animals)
    puts "Please enter the number of your selection."
    puts "You may also enter SEARCH, BACK or EXIT"

    input = gets.strip

    if input.to_i > 0 && input.to_i <= animals.size
      show_animal(animals[input.to_i - 1])
    elsif input.downcase == "back"
      list_categories
    elsif input.downcase == "search"
      search_by_name
    elsif input.downcase == "exit"
      goodbye
    else
      puts "Invalid input."
      category_menu(animals)
    end
  end

  def search_by_name
    puts "Please type the name of the animal you wish to search for:"

    name = gets.strip.split.collect do |part|
      part.capitalize
    end.join(" ")

    puts ""
    puts "One moment please. Searching for \"#{name}\"."
    build_all
    if SeaLife::Animal.find_by_name(name)
      show_animal(SeaLife::Animal.find_by_name(name))
    else
      puts ""
      puts ""
      puts "Sorry, there was no match for \"#{name}\"."
      puts "Returning to Main Menu."
      sleep(3)
      list_categories
    end
  end

  def build_all
    SeaLife::Category.all.each do |category|
      make_animals_from_category(category) if category.animals.size == 0
    end
  end

  def goodbye
    puts "------------------------------------------------------------"
    puts ""
    puts "      _________             .____    .__  _____"
    puts "     /   _____/ ____ _____  |    |   |__|/ ____\\____"
    puts "     \\_____  \\_/ __ \\\\__  \\ |    |   |  \\   __\\/ __ \\"
    puts "     /        \\  ___/ / __ \\|    |___|  ||  | \\  ___/"
    puts "    /_________/\\____/ _____/ ________\\__||__|  \\____/"
    puts "                                        See you soon!"
    puts ""
    puts "------------------------------------------------------------"
  end
end
