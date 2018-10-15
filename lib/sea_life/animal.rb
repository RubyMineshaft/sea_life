class SeaLife::Animal
  attr_accessor :name, :distribution, :habitat, :habits, :status, :taxonomy, :short_desc, :longer_desc, :scientific_name
  attr_reader :category

  @@all = []

  def initialize(info)
    info.each { |k, v| self.send("#{k}=", v) }
    @@all << self
  end

  def category=(category_name)
    @category = SeaLife::Category.find_by_name(category_name)
    @category.animals << self
  end


end
