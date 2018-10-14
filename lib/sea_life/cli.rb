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
    @categories = SeaLife::Category.all
    @categories.each_with_index do |category, i|
      puts "#{i + 1}. #{category.name}"
    end
  end

end
