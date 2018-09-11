class Station

  attr_reader :station_info, :zone, :name

  def initialize(name, zone)
    @name = name
    @zone = zone
    @station_info = { name: name, zone: zone }
  end

end
