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
    @categories = SeaLife::Categories.all
  end

end
