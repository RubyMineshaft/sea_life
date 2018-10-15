class SeaLife::CLI

  def call
    puts <<-DOC
------------------------------------------------------------

      _________             .____    .__  _____
     /   _____/ ____ _____  |    |   |__|/ ____\\____
     \\_____  \\_/ __ \\\\__  \\ |    |   |  \\   __\\/ __ \\
     /        \\  ___/ / __ \\|    |___|  ||  | \\  ___/
    /_________/\\____/ _____/ ________\\__||__|  \\____/


------------------------------------------------------------

Welcome!
DOC

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
    animals = []
    category.animals.each_with_index do |animal, i|
      puts "#{i + 1}. #{animal.name}"
      animals << animal
    end
    puts ""
    category_menu(animals)
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
    puts "You may also enter \"EXIT\"."
    input = gets.strip
    if input.to_i > 0
      list_animals(categories[input.to_i - 1])
    elsif input.downcase == "exit"
      goodbye
    else
      puts "Invalid input."
      main_menu(categories)
    end
  end

  def category_menu(animals)
    puts "Please enter the number of your selection."
    puts "You may also enter BACK or EXIT"
    input = gets.strip
    if input.to_i > 0
      show_animal(animals[input.to_i - 1])
    elsif input.downcase == "back"
      list_categories
    elsif input.downcase == "exit"
      goodbye
    else
      puts "Invalid input."
      category_menu(animals)
    end
  end



  def goodbye
    puts <<-DOC
------------------------------------------------------------

      _________             .____    .__  _____
     /   _____/ ____ _____  |    |   |__|/ ____\\____
     \\_____  \\_/ __ \\\\__  \\ |    |   |  \\   __\\/ __ \\
     /        \\  ___/ / __ \\|    |___|  ||  | \\  ___/
    /_________/\\____/ _____/ ________\\__||__|  \\____/
                                        See you soon!

------------------------------------------------------------
DOC

  end

end
