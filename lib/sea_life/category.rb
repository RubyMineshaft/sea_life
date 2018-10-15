class SeaLife::Category
  attr_accessor :name, :url, :animals, :description

  @@all = []

  def initialize(hash)
    hash.each { |k, v| self.send("#{k}=", v) }
    self.class.all << self
    @animals = []
  end

  def self.all
    @@all
  end

  def self.find_by_name(name)
    self.all.detect { |c| c.name == name }
  end

end
