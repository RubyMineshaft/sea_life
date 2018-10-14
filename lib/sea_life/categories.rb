class SeaLife::Category
  attr_accessor :name, :url

  @@all = []

  def initialize(hash)
    hash.each { |k, v| self.send("#{k}=", v) }
    self.class.all << self
  end

  def self.all
    @@all
  end

end
