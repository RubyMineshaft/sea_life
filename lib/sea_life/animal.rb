class SeaLife::Animal
  attr_accessor :name, :category, :distribution, :habitat, :habits, :status, :taxonomy, :short_desc, :longer_desc

  def initialize(info)
    info.each { |k, v| self.send("#{k}=", v) }
  end


end
