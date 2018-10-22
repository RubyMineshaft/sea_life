class SeaLife::Category
  extend SeaLife::Findable
  attr_accessor :name, :url, :animals

  @@all = []

  def initialize(hash)
    hash.each { |k, v| self.send("#{k}=", v) }
    self.class.all << self
    @animals = []
  end

  def self.all
    @@all
  end

end
