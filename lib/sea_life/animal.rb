class SeaLife::Animal
  attr_accessor :name, :distribution, :habitat, :habits, :status, :taxonomy, :short_desc, :longer_desc
  attr_reader :category

  def initialize(info)
    info.each { |k, v| self.send("#{k}=", v) }
  end

  def category=(category_name)
    @category = SeaLife::Category.find_by_name(category_name)
    @category.animals << self
  end


end
