class SeaLife::CLI

  def call
    puts <<-DOC
------------------------------------------------
                  SeaLife
------------------------------------------------

Welcome to Sea Life!
Choose a category to learn about:

DOC
    list_categories
  end

  def list_categories
    puts <<-DOC
1. Cephalopods, crustaceans, & other shellfish
2. Corals and other invertebrates
3. Marine mammals
4. Marine science and ecosystems
5. Ocean fishes
6. Sea turtles & reptiles
7. Seabirds
8. Sharks & rays
    DOC
  end

end
