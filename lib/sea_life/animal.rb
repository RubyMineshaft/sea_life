class SeaLife::Animal
  attr_accessor :url, :category, :name, :distribution, :habitat, :habits, :status, :taxonomy, :short_desc, :longer_desc, :scientific_name


  @@all = []

  def initialize(info)
    info.each { |k, v| self.send("#{k}=", v) }
    @@all << self
  end

  def category=(category)
    # @category = SeaLife::Category.find_by_name(category_name)
    category.animals << self
  end

  def add_info(info)
    info.each { |k, v| self.send("#{k}=", v) }
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.detect { |animal| animal.name == name }
  end


end
